# instantFlashHelper
I got myself tired to always drag and drop .bin file after compiling it from Mbed so i made this ...

If you want to use it just call it and pass the path where to flash your target:
```sh

./instantFlashHelper /media/user/cardName

```

> Take care that the script will move all the `.bin` you will download to the path you've specified. So please take care to what you download while using it.

If you just want to copy the `.bin` instead of moving it replace the `mv` command by `cp` (maybe i'll make it as a built-in option on day ...)
