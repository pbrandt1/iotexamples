{
  "targets": [
    {
      "target_name": "pikacam",
      "sources": [ "pikacam.cc" ],
            "link_settings": {
                "libraries": ["-lopencv_shape", "-lopencv_stitching", "-lopencv_objdetect", "-lopencv_superres", "-lopencv_videostab", "-lopencv_calib3d", "-lopencv_features2d", "-lopencv_highgui", "-lopencv_videoio", "-lopencv_imgcodecs", "-lopencv_video", "-lopencv_photo", "-lopencv_ml", "-lopencv_imgproc", "-lopencv_flann", "-lopencv_core", "-lopencv_hal"]
            },
            "cflags": [
                "-g", "-std=c++11", "-Wall"
            ],
            "conditions": [
                ['OS=="linux"', {
                    'include_dirs': [
                        '/usr/local/include',
						"<!(node -e \"require('nan')\")"
                        ],
                    'link_settings': {
                        'library_dirs': ['/usr/local/lib']
                    },
                    'cflags!': ['-fno-exceptions'],
                    'cflags_cc!': ['-fno-rtti', '-fno-exceptions']
                }],
                ['OS=="mac"', {
                    'include_dirs': [
                        '/opt/local/include',
						"<!(node -e \"require('nan')\")"
                        ],
                    'link_settings': {
                        'library_dirs': ['/opt/local/lib']
                    },
                    'xcode_settings': {
                        'OTHER_CFLAGS': [
                            "-mmacosx-version-min=10.7",
                            "-std=c++11",
                            "-stdlib=libc++"
                        ],
                        'GCC_ENABLE_CPP_EXCEPTIONS': 'YES',
                        'GCC_ENABLE_CPP_RTTI': 'YES'
                    }
                }]
            ]
    }
  ]
}
