# TEMPLATE ANDROID FMX / DELPHI / FIREMONKEY

**NB :: DELETE IF ON USES ERROR, THAT BECAUSE I USES OTHER COMPONENT AND I FORGOT TO DELETE**

**HOW TO ADD NEW FRAME**

1. Add File "frTemp.pas" on directory "frames/frTemp.pas"

![alt text](https://github.com/dondonondon/FMX_TemplateAndroid_Firemonkey/blob/master/assets/img/1.png?raw=true)

2. Save as "frTemp.pas" (for example save as to "frHome.pas")

![alt text](https://github.com/dondonondon/FMX_TemplateAndroid_Firemonkey/blob/master/assets/img/2.png?raw=true)

3. Double Click frHome.pas then reName TFrame on properties (for example rename to FHome)

![alt text](https://github.com/dondonondon/FMX_TemplateAndroid_Firemonkey/blob/master/assets/img/3.PNG?raw=true)

4. Open Code on frHome.pas / FHome. go to procedure setFrame. then change "fnGetClient(FMain, Temp);" to "fnGetClient(FMain, FHome);"

![alt text](https://github.com/dondonondon/FMX_TemplateAndroid_Firemonkey/blob/master/assets/img/4.PNG?raw=true)

5. Open "uMain.pas" on path sources then add const HOME = 'HOME'

![alt text](https://github.com/dondonondon/FMX_TemplateAndroid_Firemonkey/blob/master/assets/img/5.PNG?raw=true)

6. Open "uGoFrame", then add uses "frHome.pas", after that add some code on procedure "createFrame" and "fnGetFrame(st, transFR : String);" Check Pict

![alt text](https://github.com/dondonondon/FMX_TemplateAndroid_Firemonkey/blob/master/assets/img/6.PNG?raw=true)

7. to call Frame FHome just use procedure like this (if Frame active is FLogin) "fnGoFrame(LOGIN, HOME);". Note :: Login is Frame Active and Home is showing the Frame.

![alt text](https://github.com/dondonondon/FMX_TemplateAndroid_Firemonkey/blob/master/assets/img/7.PNG?raw=true)



