#include "opencv2/opencv.hpp"
#include <iostream>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <time.h>
#include <string.h>
#include <stdio.h>

#define HELLO_PORT 10101
#define HELLO_GROUP "239.255.0.1"

using namespace cv;

int main(int, char**)
{


    struct sockaddr_in addr;
    int fd, cnt;
    struct ip_mreq mreq;
    char *message;

    /* create what looks like an ordinary UDP socket */
    if ((fd=socket(AF_INET,SOCK_DGRAM,0)) < 0) {
    perror("socket");
    exit(1);
    }

    /* set up destination address */
    memset(&addr,0,sizeof(addr));
    addr.sin_family=AF_INET;
    addr.sin_addr.s_addr=inet_addr(HELLO_GROUP);
    addr.sin_port=htons(HELLO_PORT);



    VideoCapture cap(0); // open the default camera
    if(!cap.isOpened())  // check if we succeeded
        return -1;

    Mat edges;
    //namedWindow("edges",1);
    for(;;)
    {
        Mat frame;
        cap >> frame; // get a new frame from camera
        cvtColor(frame, edges, CV_BGR2GRAY);
        GaussianBlur(edges, edges, Size(7,7), 1.5, 1.5);
        Canny(edges, edges, 0, 30, 3);
        //imshow("edges", edges);
        if(waitKey(30) >= 0) break;

        std::vector<int> params = std::vector<int>(2);
        params[0] = CV_IMWRITE_JPEG_QUALITY;
        params[1] = 50; //jpeg quality
        std::vector<unsigned char> buff;
        cv::imencode(".jpg", edges, buff, params);
        // std::cout << reinterpret_cast<char*>(&buff[0]);


        // pipe to udp multicast
        /* now just sendto() our destination! */
        int length = buff.size();
        std::cout << length << std::endl;
        message = reinterpret_cast<char*>(&buff[0]);
        if (sendto(fd,message,length,0,(struct sockaddr *) &addr,
             sizeof(addr)) < 0) {
           perror("sendto");
           exit(1);
        }
    }
    // the camera will be deinitialized automatically in VideoCapture destructor
    return 0;
}