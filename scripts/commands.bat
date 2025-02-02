@echo off

:: For tableexporter, make sure your to set your locale's decimal setting
:: to . instead of , if you have a non US region setting, otherwise clean.py
:: won't convert float characters correctly. This can be done in:
:: Start / Run / intl.cpl / Additional Settings / Numbers
SET tableexporter=%USERPROFILE%\Desktop\wargame3_server\mod\WGTableExporter.exe

SET wargamedata=%USERPROFILE%\Documents\GitHub\wargame-data
SET wargamesteam="D:\Steam\steamapps\common\Wargame Red Dragon\Data\WARGAME\PC"
SET rawsdir=%wargamedata%\raws
SET datadir=%wargamedata%\data

:: SET versions=(510053208 510064564)
SET versions=(48574)

FOR %%I IN %versions% DO (
    REM Use /Q for interactive mode
    rmdir /Q %rawsdir%\%%I
    rmdir /Q %datadir%\%%I

    python dump.py %tableexporter% %wargamesteam% %%I
    python export.py --fobs %rawsdir%  %%I %datadir%
    python clean.py %rawsdir% %%I  %datadir%
    python fobs.py %rawsdir% %%I %datadir%

)

pause
