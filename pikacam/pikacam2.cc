#include <node.h>
#include "opencv2/opencv.hpp"
#include <nan.h>
#include <chrono>
#include <thread>

using namespace v8;

char *addr = "239.255.0.2";
int port = 8000;

void OnData(const FunctionCallbackInfo<Value>& args) {
  Isolate* isolate = Isolate::GetCurrent();
  HandleScope scope(isolate);
  
    cv::VideoCapture cap(0); // open the default camera
    if(!cap.isOpened())  // check if we succeeded
        throw 20;

  Local<Function> cb = Local<Function>::Cast(args[0]);
      
    //cv::Mat edges;
    cv::namedWindow("edges",1);
    for(;;)
    {
        cv::Mat frame;
        cap >> frame; // get a new frame from camera
        
        //cv::cvtColor(frame, frame, CV_BGR2GRAY);
        //cv::GaussianBlur(edges, edges, cv::Size(7,7), 1.5, 1.5);
        //cv::Canny(edges, edges, 0, 30, 3);
        cv::imshow("edges", frame);
        if(cv::waitKey(30) >= 0) break;
        
        std::vector<int> params = std::vector<int>(2);
        params[0] = CV_IMWRITE_JPEG_QUALITY;
        params[1] = 50; //jpeg quality
        std::vector<unsigned char> buff;
        cv::imencode(".jpg", frame, buff, params);
        int length = buff.size();
        Local<Value> argv[] = { NanNewBufferHandle(reinterpret_cast<char*>(&buff[0]), length) };
        
		cb->Call(isolate->GetCurrentContext()->Global(), 1, argv);
		std::this_thread::sleep_for(std::chrono::milliseconds(20));
    }
  
}

void init(Handle<Object> exports) {
  NODE_SET_METHOD(exports, "onData", OnData);
}

NODE_MODULE(pikacam, init)
