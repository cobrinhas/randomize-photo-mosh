# randomize-photo-mosh

Outputs random image modifications to a provided image using photo-mosh

## Running

This automation is done in Dart, so make sure to get Dart SDK in order to run it in whatever environment you are on. Else you can always execute the binary available in `bin` folder if you are under a x64 Linux environment.

Running is as simple as:

```
> dart run

Welcome to randomize-photo-mosh! Below are the mandatory arguments you need to specify.
-i, --input (mandatory)     Specifies the file path of the .jpeg/.png to mosh
-o, --output (mandatory)    Specifies the output directory path where the moshed photo will appear
-n, --name                  Specifies the file name of the moshed photo
-m, --mode                  Specifies the output mode (jpeg, gif, webm) of the moshed photo.
                            (defaults to "jpeg")
-h, --[no-]headful          Specifies whether the automation should run in headful or headless mode. (defaults to headless)```

### Demo (headful mode)

https://user-images.githubusercontent.com/26190214/185397338-22022e14-0480-4663-91fb-4b1c4d8308ef.mp4
