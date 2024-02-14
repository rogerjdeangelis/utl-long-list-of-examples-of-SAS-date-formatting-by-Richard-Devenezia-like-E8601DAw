%let pgm=utl-long-list-of-examples-of-SAS-dates-formatting-by-Richard-Devenezia-like-E8601DAw

Long list of examples of SAS dates formatting by Richard Devenezia like E8601DAw

I find this usefull when I want a particular format

I added the iso dates to Richards formated dates,
ISO dates have only one length, 10 bytes.

Times not included

code to create list below
https://www.devenezia.com/cgi-bin/push/date-formats.sas

and
http://www.devenezia.com/downloads/sas/samples/

Added ISO dates

filename invokes catalog 'work.formats.invokes.source';

data _null_;
infile cards dlm=',' missover;
length format range1 range2 $60;
input  format range1 range2;
file invokes;

if format ne '';
if range2 ne ''
  then put '%xw (' format= ',' range1= ',' range2= ')';
  else put '%w  (' format= ',' range1= ')';

cards;

E8601DAw.,         10 to 10
E8601DNw.,         10 to 10
B8601DAw.,         10 to 10
B8601DNw.,         10 to 10

DATEw.,              5 to 9
DAYw.,               3 to 32
DDMMYYw.,            2 to 10
DDMMYYxw.,   BCDNPS, 2 to 10
DOWNAMEw.,           1 to 32

EURDFDDw.,  2 to 8
EURDFDEw.,  5 to 9
EURDFDNw.,  1 to 32
EURDFDWNw., 1 to 32
EURDFMNw.,  1 to 32
EURDFMYw.,  5 to 7
EURDFWDXw., 17 to 32  * varies by dflang
EURDFWKXw., 3 to 37  * varies by dflang

JULDAYw., 3 to 32
JULIANw., 5 to 7

MINGUOw., 1 to 10

MMDDYYw.,           2 to 8
MMDDYYxw.,  BCDNPS, 2 to 10
MMYYw.,             5 to 32
MMYYxw.,     CDNPS, 5 to 32
MONNAMEw.,          1 to 32
MONTHw.,            1 to 21
MONYYw.,            5 to 7

NENGOw., 2 to 10

PDJULGw., 3 to 16
PDJULIw., 3 to 16


QTRw.,              1 to 32
QTRRw.,             3 to 32
WEEKDATEw.,         3 to 37
WEEKDATXw.,         3 to 37
WEEKDAYw.,          1 to 32
WORDDATEw.,         3 to 32
WORDDATXw.,         3 to 32
YEARw.,             2 to 32
YYMMw.,             5 to 32
YYMMxw.,     CDNPS, 5 to 32
YYMMDDw.,           2 to 8
YYMMDDxw.,  BCDNPS, 2 to 10
YYMONw.,            5 to 32
YYQw.,              4 to 32
YYQxw.,      CDNPS, 4 to 32
YYQRw.,             6 to 32
YYQRxw.,     CDNPS, 6 to 32
;
run;

%macro xw (format=, range1=, range2=);
  %let fmt = %sysfunc (tranwrd(&format,xw.,.));

  put ;
  put "&fmt" @12 '-> ' date &fmt;

  %do i = 1 %to %length(&range1);
    %let x = %substr(&range1,&i,1);

    %let A = %scan (&range2,1);
    %let B = %scan (&range2,3);

    %if &x = N and (&format=YYMMDDxw. or &format=MMDDYYxw. or &format=DDMMYYxw.) %then
      %let B = %eval(&B-2);

    %do j = &A %to &B;
      %let fmt = %sysfunc(tranwrd(&format,xw.,&x.&j..));
      put "&fmt" @12 '-> ' date  &fmt;
    %end;
  %end;
%mend;

%macro w (format=, range1=);
  %let fmt = %sysfunc (tranwrd(&format,w.,.));

  put ;
  put "&fmt" @12 '-> ' date &fmt;

  %let A = %scan (&range1,1);
  %let B = %scan (&range1,3);

  %do i = &A %to &B;
    %let fmt = %sysfunc(tranwrd(&format,w,&i));
    put "&fmt" @12 '-> ' date  &fmt;
  %end;

%mend;

options   source2   mprint;
options nosource2 nomprint;

data _null_;

  date = today();

  %include invokes;

run;

data simplify;
  input;
  fmt=substr(_infile_,1,13);
  therest=left(substr(_infile_,14));
  lagtherest =lag(therest);
  if therest=lagtherest  then delete;
  drop lagtherest;
  put @3 fmt @18 therest;
cards4;
E8601DA.   -> 2022-05-14
E8601DA10. -> 2022-05-14

E8601DN.   -> 1960-01-01
E8601DN10. -> 1960-01-01

B8601DA.   ->   20220514
B8601DA10. ->   20220514

B8601DN.   ->   19600101
B8601DN10. ->   19600101

DATE.      -> 14MAY22
DATE5.     -> 14MAY
DATE6.     ->  14MAY
DATE7.     -> 14MAY22
DATE8.     ->  14MAY22
DATE9.     -> 14MAY2022

DAY.       -> 14
DAY3.      ->  14
DAY4.      ->   14
DAY5.      ->    14
DAY6.      ->     14
DAY7.      ->      14
DAY8.      ->       14
DAY9.      ->        14
DAY10.     ->         14
DAY11.     ->          14
DAY12.     ->           14
DAY13.     ->            14
DAY14.     ->             14
DAY15.     ->              14
DAY16.     ->               14
DAY17.     ->                14
DAY18.     ->                 14
DAY19.     ->                  14
DAY20.     ->                   14
DAY21.     ->                    14
DAY22.     ->                     14
DAY23.     ->                      14
DAY24.     ->                       14
DAY25.     ->                        14
DAY26.     ->                         14
DAY27.     ->                          14
DAY28.     ->                           14
DAY29.     ->                            14
DAY30.     ->                             14
DAY31.     ->                              14
DAY32.     ->                               14

DDMMYY.    -> 14/05/22
DDMMYY2.   -> 14
DDMMYY3.   ->  14
DDMMYY4.   -> 1405
DDMMYY5.   -> 14/05
DDMMYY6.   -> 140522
DDMMYY7.   ->  140522
DDMMYY8.   -> 14/05/22
DDMMYY9.   ->  14/05/22
DDMMYY10.  -> 14/05/2022

DDMMYY.    -> 14/05/22
DDMMYYB2.  -> 14
DDMMYYB3.  ->  14
DDMMYYB4.  -> 1405
DDMMYYB5.  -> 14 05
DDMMYYB6.  -> 140522
DDMMYYB7.  ->  140522
DDMMYYB8.  -> 14 05 22
DDMMYYB9.  ->  14 05 22
DDMMYYB10. -> 14 05 2022
DDMMYYC2.  -> 14
DDMMYYC3.  ->  14
DDMMYYC4.  -> 1405
DDMMYYC5.  -> 14:05
DDMMYYC6.  -> 140522
DDMMYYC7.  ->  140522
DDMMYYC8.  -> 14:05:22
DDMMYYC9.  ->  14:05:22
DDMMYYC10. -> 14:05:2022
DDMMYYD2.  -> 14
DDMMYYD3.  ->  14
DDMMYYD4.  -> 1405
DDMMYYD5.  -> 14-05
DDMMYYD6.  -> 140522
DDMMYYD7.  ->  140522
DDMMYYD8.  -> 14-05-22
DDMMYYD9.  ->  14-05-22
DDMMYYD10. -> 14-05-2022
DDMMYYN2.  -> 14
DDMMYYN3.  ->  14
DDMMYYN4.  -> 1405
DDMMYYN5.  ->  1405
DDMMYYN6.  -> 140522
DDMMYYN7.  ->  140522
DDMMYYN8.  -> 14052022
DDMMYYP2.  -> 14
DDMMYYP3.  ->  14
DDMMYYP4.  -> 1405
DDMMYYP5.  -> 14.05
DDMMYYP6.  -> 140522
DDMMYYP7.  ->  140522
DDMMYYP8.  -> 14.05.22
DDMMYYP9.  ->  14.05.22
DDMMYYP10. -> 14.05.2022
DDMMYYS2.  -> 14
DDMMYYS3.  ->  14
DDMMYYS4.  -> 1405
DDMMYYS5.  -> 14/05
DDMMYYS6.  -> 140522
DDMMYYS7.  ->  140522
DDMMYYS8.  -> 14/05/22
DDMMYYS9.  ->  14/05/22
DDMMYYS10. -> 14/05/2022

DOWNAME.   ->  Saturday
DOWNAME1.  -> S
DOWNAME2.  -> Sa
DOWNAME3.  -> Sat
DOWNAME4.  -> Satu
DOWNAME5.  -> Satur
DOWNAME6.  -> Saturd
DOWNAME7.  -> Saturda
DOWNAME8.  -> Saturday
DOWNAME9.  ->  Saturday
DOWNAME10. ->   Saturday
DOWNAME11. ->    Saturday
DOWNAME12. ->     Saturday
DOWNAME13. ->      Saturday
DOWNAME14. ->       Saturday
DOWNAME15. ->        Saturday
DOWNAME16. ->         Saturday
DOWNAME17. ->          Saturday
DOWNAME18. ->           Saturday
DOWNAME19. ->            Saturday
DOWNAME20. ->             Saturday
DOWNAME21. ->              Saturday
DOWNAME22. ->               Saturday
DOWNAME23. ->                Saturday
DOWNAME24. ->                 Saturday
DOWNAME25. ->                  Saturday
DOWNAME26. ->                   Saturday
DOWNAME27. ->                    Saturday
DOWNAME28. ->                     Saturday
DOWNAME29. ->                      Saturday
DOWNAME30. ->                       Saturday
DOWNAME31. ->                        Saturday
DOWNAME32. ->                         Saturday

EURDFDD.   -> 14.05.22
EURDFDD2.  -> 14
EURDFDD3.  ->  14
EURDFDD4.  -> 1405
EURDFDD5.  -> 14.05
EURDFDD6.  -> 140522
EURDFDD7.  ->  140522
EURDFDD8.  -> 14.05.22

EURDFDE.   -> 14MAY22
EURDFDE5.  -> 14MAY
EURDFDE6.  ->  14MAY
EURDFDE7.  -> 14MAY22
EURDFDE8.  ->  14MAY22
EURDFDE9.  -> 14MAY2022

EURDFDN.   -> 6
EURDFDN1.  -> 6
EURDFDN2.  ->  6
EURDFDN3.  ->   6
EURDFDN4.  ->    6
EURDFDN5.  ->     6
EURDFDN6.  ->      6
EURDFDN7.  ->       6
EURDFDN8.  ->        6
EURDFDN9.  ->         6
EURDFDN10. ->          6
EURDFDN11. ->           6
EURDFDN12. ->            6
EURDFDN13. ->             6
EURDFDN14. ->              6
EURDFDN15. ->               6
EURDFDN16. ->                6
EURDFDN17. ->                 6
EURDFDN18. ->                  6
EURDFDN19. ->                   6
EURDFDN20. ->                    6
EURDFDN21. ->                     6
EURDFDN22. ->                      6
EURDFDN23. ->                       6
EURDFDN24. ->                        6
EURDFDN25. ->                         6
EURDFDN26. ->                          6
EURDFDN27. ->                           6
EURDFDN28. ->                            6
EURDFDN29. ->                             6
EURDFDN30. ->                              6
EURDFDN31. ->                               6
EURDFDN32. ->                                6

EURDFDWN.  ->  Saturday
EURDFDWN1. -> S
EURDFDWN2. -> Sa
EURDFDWN3. -> Sat
EURDFDWN4. -> Satu
EURDFDWN5. -> Satur
EURDFDWN6. -> Saturd
EURDFDWN7. -> Saturda
EURDFDWN8. -> Saturday
EURDFDWN9. ->  Saturday
EURDFDWN10.->   Saturday
EURDFDWN11.->    Saturday
EURDFDWN12.->     Saturday
EURDFDWN13.->      Saturday
EURDFDWN14.->       Saturday
EURDFDWN15.->        Saturday
EURDFDWN16.->         Saturday
EURDFDWN17.->          Saturday
EURDFDWN18.->           Saturday
EURDFDWN19.->            Saturday
EURDFDWN20.->             Saturday
EURDFDWN21.->              Saturday
EURDFDWN22.->               Saturday
EURDFDWN23.->                Saturday
EURDFDWN24.->                 Saturday
EURDFDWN25.->                  Saturday
EURDFDWN26.->                   Saturday
EURDFDWN27.->                    Saturday
EURDFDWN28.->                     Saturday
EURDFDWN29.->                      Saturday
EURDFDWN30.->                       Saturday
EURDFDWN31.->                        Saturday
EURDFDWN32.->                         Saturday

EURDFMN.   ->       May
EURDFMN1.  -> M
EURDFMN2.  -> Ma
EURDFMN3.  -> May
EURDFMN4.  ->  May
EURDFMN5.  ->   May
EURDFMN6.  ->    May
EURDFMN7.  ->     May
EURDFMN8.  ->      May
EURDFMN9.  ->       May
EURDFMN10. ->        May
EURDFMN11. ->         May
EURDFMN12. ->          May
EURDFMN13. ->           May
EURDFMN14. ->            May
EURDFMN15. ->             May
EURDFMN16. ->              May
EURDFMN17. ->               May
EURDFMN18. ->                May
EURDFMN19. ->                 May
EURDFMN20. ->                  May
EURDFMN21. ->                   May
EURDFMN22. ->                    May
EURDFMN23. ->                     May
EURDFMN24. ->                      May
EURDFMN25. ->                       May
EURDFMN26. ->                        May
EURDFMN27. ->                         May
EURDFMN28. ->                          May
EURDFMN29. ->                           May
EURDFMN30. ->                            May
EURDFMN31. ->                             May
EURDFMN32. ->                              May

EURDFMY.   -> MAY22
EURDFMY5.  -> MAY22
EURDFMY6.  ->  MAY22
EURDFMY7.  -> MAY2022

EURDFWDX.  ->        14 May 2022
EURDFWDX17.->       14 May 2022
EURDFWDX18.->        14 May 2022
EURDFWDX19.->         14 May 2022
EURDFWDX20.->          14 May 2022
EURDFWDX21.->           14 May 2022
EURDFWDX22.->            14 May 2022
EURDFWDX23.->             14 May 2022
EURDFWDX24.->              14 May 2022
EURDFWDX25.->               14 May 2022
EURDFWDX26.->                14 May 2022
EURDFWDX27.->                 14 May 2022
EURDFWDX28.->                  14 May 2022
EURDFWDX29.->                   14 May 2022
EURDFWDX30.->                    14 May 2022
EURDFWDX31.->                     14 May 2022
EURDFWDX32.->                      14 May 2022

EURDFWKX.  ->         Saturday, 14 May 2022
EURDFWKX3. -> Sat
EURDFWKX4. ->  Sat
EURDFWKX5. ->   Sat
EURDFWKX6. ->    Sat
EURDFWKX7. ->     Sat
EURDFWKX8. ->      Sat
EURDFWKX9. ->  Saturday
EURDFWKX10.->   Saturday
EURDFWKX11.->    Saturday
EURDFWKX12.->     Saturday
EURDFWKX13.->      Saturday
EURDFWKX14.->       Saturday
EURDFWKX15.->  Sat, 14 May 22
EURDFWKX16.->   Sat, 14 May 22
EURDFWKX17.->  Sat, 14 May 2022
EURDFWKX18.->   Sat, 14 May 2022
EURDFWKX19.->    Sat, 14 May 2022
EURDFWKX20.->     Sat, 14 May 2022
EURDFWKX21.->      Sat, 14 May 2022
EURDFWKX22.->       Sat, 14 May 2022
EURDFWKX23.->   Saturday, 14 May 2022
EURDFWKX24.->    Saturday, 14 May 2022
EURDFWKX25.->     Saturday, 14 May 2022
EURDFWKX26.->      Saturday, 14 May 2022
EURDFWKX27.->       Saturday, 14 May 2022
EURDFWKX28.->        Saturday, 14 May 2022
EURDFWKX29.->         Saturday, 14 May 2022
EURDFWKX30.->          Saturday, 14 May 2022
EURDFWKX31.->           Saturday, 14 May 2022
EURDFWKX32.->            Saturday, 14 May 2022
EURDFWKX33.->             Saturday, 14 May 2022
EURDFWKX34.->              Saturday, 14 May 2022
EURDFWKX35.->               Saturday, 14 May 2022
EURDFWKX36.->                Saturday, 14 May 2022
EURDFWKX37.->                 Saturday, 14 May 2022

JULDAY.    -> 134
JULDAY3.   -> 134
JULDAY4.   ->  134
JULDAY5.   ->   134
JULDAY6.   ->    134
JULDAY7.   ->     134
JULDAY8.   ->      134
JULDAY9.   ->       134
JULDAY10.  ->        134
JULDAY11.  ->         134
JULDAY12.  ->          134
JULDAY13.  ->           134
JULDAY14.  ->            134
JULDAY15.  ->             134
JULDAY16.  ->              134
JULDAY17.  ->               134
JULDAY18.  ->                134
JULDAY19.  ->                 134
JULDAY20.  ->                  134
JULDAY21.  ->                   134
JULDAY22.  ->                    134
JULDAY23.  ->                     134
JULDAY24.  ->                      134
JULDAY25.  ->                       134
JULDAY26.  ->                        134
JULDAY27.  ->                         134
JULDAY28.  ->                          134
JULDAY29.  ->                           134
JULDAY30.  ->                            134
JULDAY31.  ->                             134
JULDAY32.  ->                              134

JULIAN.    -> 22134
JULIAN5.   -> 22134
JULIAN6.   ->  22134
JULIAN7.   -> 2022134

MINGUO.    -> **/05/14
MINGUO1.   -> *
MINGUO2.   -> **
MINGUO3.   -> 111
MINGUO4.   -> **05
MINGUO5.   -> 11105
MINGUO6.   -> **0514
MINGUO7.   -> 1110514
MINGUO8.   -> **/05/14
MINGUO9.   -> 111/05/14
MINGUO10.  -> 0111/05/14

MMDDYY.    -> 05/14/22
MMDDYY2.   -> 05
MMDDYY3.   ->  05
MMDDYY4.   -> 0514
MMDDYY5.   -> 05/14
MMDDYY6.   -> 051422
MMDDYY7.   ->  051422
MMDDYY8.   -> 05/14/22

MMDDYY.    -> 05/14/22
MMDDYYB2.  -> 05
MMDDYYB3.  ->  05
MMDDYYB4.  -> 0514
MMDDYYB5.  -> 05 14
MMDDYYB6.  -> 051422
MMDDYYB7.  ->  051422
MMDDYYB8.  -> 05 14 22
MMDDYYB9.  ->  05 14 22
MMDDYYB10. -> 05 14 2022
MMDDYYC2.  -> 05
MMDDYYC3.  ->  05
MMDDYYC4.  -> 0514
MMDDYYC5.  -> 05:14
MMDDYYC6.  -> 051422
MMDDYYC7.  ->  051422
MMDDYYC8.  -> 05:14:22
MMDDYYC9.  ->  05:14:22
MMDDYYC10. -> 05:14:2022
MMDDYYD2.  -> 05
MMDDYYD3.  ->  05
MMDDYYD4.  -> 0514
MMDDYYD5.  -> 05-14
MMDDYYD6.  -> 051422
MMDDYYD7.  ->  051422
MMDDYYD8.  -> 05-14-22
MMDDYYD9.  ->  05-14-22
MMDDYYD10. -> 05-14-2022
MMDDYYN2.  -> 05
MMDDYYN3.  ->  05
MMDDYYN4.  -> 0514
MMDDYYN5.  ->  0514
MMDDYYN6.  -> 051422
MMDDYYN7.  ->  051422
MMDDYYN8.  -> 05142022
MMDDYYP2.  -> 05
MMDDYYP3.  ->  05
MMDDYYP4.  -> 0514
MMDDYYP5.  -> 05.14
MMDDYYP6.  -> 051422
MMDDYYP7.  ->  051422
MMDDYYP8.  -> 05.14.22
MMDDYYP9.  ->  05.14.22
MMDDYYP10. -> 05.14.2022
MMDDYYS2.  -> 05
MMDDYYS3.  ->  05
MMDDYYS4.  -> 0514
MMDDYYS5.  -> 05/14
MMDDYYS6.  -> 051422
MMDDYYS7.  ->  051422
MMDDYYS8.  -> 05/14/22
MMDDYYS9.  ->  05/14/22
MMDDYYS10. -> 05/14/2022

MMYY.      -> 05M2022
MMYY5.     -> 05M22
MMYY6.     ->  05M22
MMYY7.     -> 05M2022
MMYY8.     ->  05M2022
MMYY9.     ->   05M2022
MMYY10.    ->    05M2022
MMYY11.    ->     05M2022
MMYY12.    ->      05M2022
MMYY13.    ->       05M2022
MMYY14.    ->        05M2022
MMYY15.    ->         05M2022
MMYY16.    ->          05M2022
MMYY17.    ->           05M2022
MMYY18.    ->            05M2022
MMYY19.    ->             05M2022
MMYY20.    ->              05M2022
MMYY21.    ->               05M2022
MMYY22.    ->                05M2022
MMYY23.    ->                 05M2022
MMYY24.    ->                  05M2022
MMYY25.    ->                   05M2022
MMYY26.    ->                    05M2022
MMYY27.    ->                     05M2022
MMYY28.    ->                      05M2022
MMYY29.    ->                       05M2022
MMYY30.    ->                        05M2022
MMYY31.    ->                         05M2022
MMYY32.    ->                          05M2022

MMYY.      -> 05M2022
MMYYC5.    -> 05:22
MMYYC6.    ->  05:22
MMYYC7.    -> 05:2022
MMYYC8.    ->  05:2022
MMYYC9.    ->   05:2022
MMYYC10.   ->    05:2022
MMYYC11.   ->     05:2022
MMYYC12.   ->      05:2022
MMYYC13.   ->       05:2022
MMYYC14.   ->        05:2022
MMYYC15.   ->         05:2022
MMYYC16.   ->          05:2022
MMYYC17.   ->           05:2022
MMYYC18.   ->            05:2022
MMYYC19.   ->             05:2022
MMYYC20.   ->              05:2022
MMYYC21.   ->               05:2022
MMYYC22.   ->                05:2022
MMYYC23.   ->                 05:2022
MMYYC24.   ->                  05:2022
MMYYC25.   ->                   05:2022
MMYYC26.   ->                    05:2022
MMYYC27.   ->                     05:2022
MMYYC28.   ->                      05:2022
MMYYC29.   ->                       05:2022
MMYYC30.   ->                        05:2022
MMYYC31.   ->                         05:2022
MMYYC32.   ->                          05:2022
MMYYD5.    -> 05-22
MMYYD6.    ->  05-22
MMYYD7.    -> 05-2022
MMYYD8.    ->  05-2022
MMYYD9.    ->   05-2022
MMYYD10.   ->    05-2022
MMYYD11.   ->     05-2022
MMYYD12.   ->      05-2022
MMYYD13.   ->       05-2022
MMYYD14.   ->        05-2022
MMYYD15.   ->         05-2022
MMYYD16.   ->          05-2022
MMYYD17.   ->           05-2022
MMYYD18.   ->            05-2022
MMYYD19.   ->             05-2022
MMYYD20.   ->              05-2022
MMYYD21.   ->               05-2022
MMYYD22.   ->                05-2022
MMYYD23.   ->                 05-2022
MMYYD24.   ->                  05-2022
MMYYD25.   ->                   05-2022
MMYYD26.   ->                    05-2022
MMYYD27.   ->                     05-2022
MMYYD28.   ->                      05-2022
MMYYD29.   ->                       05-2022
MMYYD30.   ->                        05-2022
MMYYD31.   ->                         05-2022
MMYYD32.   ->                          05-2022
MMYYN5.    ->  0522
MMYYN6.    -> 052022
MMYYN7.    ->  052022
MMYYN8.    ->   052022
MMYYN9.    ->    052022
MMYYN10.   ->     052022
MMYYN11.   ->      052022
MMYYN12.   ->       052022
MMYYN13.   ->        052022
MMYYN14.   ->         052022
MMYYN15.   ->          052022
MMYYN16.   ->           052022
MMYYN17.   ->            052022
MMYYN18.   ->             052022
MMYYN19.   ->              052022
MMYYN20.   ->               052022
MMYYN21.   ->                052022
MMYYN22.   ->                 052022
MMYYN23.   ->                  052022
MMYYN24.   ->                   052022
MMYYN25.   ->                    052022
MMYYN26.   ->                     052022
MMYYN27.   ->                      052022
MMYYN28.   ->                       052022
MMYYN29.   ->                        052022
MMYYN30.   ->                         052022
MMYYN31.   ->                          052022
MMYYN32.   ->                           052022
MMYYP5.    -> 05.22
MMYYP6.    ->  05.22
MMYYP7.    -> 05.2022
MMYYP8.    ->  05.2022
MMYYP9.    ->   05.2022
MMYYP10.   ->    05.2022
MMYYP11.   ->     05.2022
MMYYP12.   ->      05.2022
MMYYP13.   ->       05.2022
MMYYP14.   ->        05.2022
MMYYP15.   ->         05.2022
MMYYP16.   ->          05.2022
MMYYP17.   ->           05.2022
MMYYP18.   ->            05.2022
MMYYP19.   ->             05.2022
MMYYP20.   ->              05.2022
MMYYP21.   ->               05.2022
MMYYP22.   ->                05.2022
MMYYP23.   ->                 05.2022
MMYYP24.   ->                  05.2022
MMYYP25.   ->                   05.2022
MMYYP26.   ->                    05.2022
MMYYP27.   ->                     05.2022
MMYYP28.   ->                      05.2022
MMYYP29.   ->                       05.2022
MMYYP30.   ->                        05.2022
MMYYP31.   ->                         05.2022
MMYYP32.   ->                          05.2022
MMYYS5.    -> 05/22
MMYYS6.    ->  05/22
MMYYS7.    -> 05/2022
MMYYS8.    ->  05/2022
MMYYS9.    ->   05/2022
MMYYS10.   ->    05/2022
MMYYS11.   ->     05/2022
MMYYS12.   ->      05/2022
MMYYS13.   ->       05/2022
MMYYS14.   ->        05/2022
MMYYS15.   ->         05/2022
MMYYS16.   ->          05/2022
MMYYS17.   ->           05/2022
MMYYS18.   ->            05/2022
MMYYS19.   ->             05/2022
MMYYS20.   ->              05/2022
MMYYS21.   ->               05/2022
MMYYS22.   ->                05/2022
MMYYS23.   ->                 05/2022
MMYYS24.   ->                  05/2022
MMYYS25.   ->                   05/2022
MMYYS26.   ->                    05/2022
MMYYS27.   ->                     05/2022
MMYYS28.   ->                      05/2022
MMYYS29.   ->                       05/2022
MMYYS30.   ->                        05/2022
MMYYS31.   ->                         05/2022
MMYYS32.   ->                          05/2022

MONNAME.   ->       May
MONNAME1.  -> M
MONNAME2.  -> Ma
MONNAME3.  -> May
MONNAME4.  ->  May
MONNAME5.  ->   May
MONNAME6.  ->    May
MONNAME7.  ->     May
MONNAME8.  ->      May
MONNAME9.  ->       May
MONNAME10. ->        May
MONNAME11. ->         May
MONNAME12. ->          May
MONNAME13. ->           May
MONNAME14. ->            May
MONNAME15. ->             May
MONNAME16. ->              May
MONNAME17. ->               May
MONNAME18. ->                May
MONNAME19. ->                 May
MONNAME20. ->                  May
MONNAME21. ->                   May
MONNAME22. ->                    May
MONNAME23. ->                     May
MONNAME24. ->                      May
MONNAME25. ->                       May
MONNAME26. ->                        May
MONNAME27. ->                         May
MONNAME28. ->                          May
MONNAME29. ->                           May
MONNAME30. ->                            May
MONNAME31. ->                             May
MONNAME32. ->                              May

MONTH.     ->  5
MONTH1.    -> 5
MONTH2.    ->  5
MONTH3.    ->   5
MONTH4.    ->    5
MONTH5.    ->     5
MONTH6.    ->      5
MONTH7.    ->       5
MONTH8.    ->        5
MONTH9.    ->         5
MONTH10.   ->          5
MONTH11.   ->           5
MONTH12.   ->            5
MONTH13.   ->             5
MONTH14.   ->              5
MONTH15.   ->               5
MONTH16.   ->                5
MONTH17.   ->                 5
MONTH18.   ->                  5
MONTH19.   ->                   5
MONTH20.   ->                    5
MONTH21.   ->                     5

MONYY.     -> MAY22
MONYY5.    -> MAY22
MONYY6.    ->  MAY22
MONYY7.    -> MAY2022

NENGO.     -> R.04/05/14
NENGO2.    -> 04
NENGO3.    -> R04
NENGO4.    -> R.04
NENGO5.    -> R0405
NENGO6.    -> R04/05
NENGO7.    -> R040514
NENGO8.    -> R.040514
NENGO9.    -> R04/05/14
NENGO10.   -> R.04/05/14

PDJULG.    ->  "O
PDJULG3.   -> ™™O
PDJULG4.   ->  "O
PDJULG5.   ->   "O
PDJULG6.   ->    "O
PDJULG7.   ->     "O
PDJULG8.   ->      "O
PDJULG9.   ->       "O
PDJULG10.  ->        "O
PDJULG11.  ->         "O
PDJULG12.  ->          "O
PDJULG13.  ->           "O
PDJULG14.  ->            "O
PDJULG15.  ->             "O
PDJULG16.  ->              "O

PDJULI.    -> "O
PDJULI3.   -> ™™O
PDJULI4.   -> "O
PDJULI5.   ->  "O
PDJULI6.   ->   "O
PDJULI7.   ->    "O
PDJULI8.   ->     "O
PDJULI9.   ->      "O
PDJULI10.  ->       "O
PDJULI11.  ->        "O
PDJULI12.  ->         "O
PDJULI13.  ->          "O
PDJULI14.  ->           "O
PDJULI15.  ->            "O
PDJULI16.  ->             "O

QTR.       -> 2
QTR1.      -> 2
QTR2.      ->  2
QTR3.      ->   2
QTR4.      ->    2
QTR5.      ->     2
QTR6.      ->      2
QTR7.      ->       2
QTR8.      ->        2
QTR9.      ->         2
QTR10.     ->          2
QTR11.     ->           2
QTR12.     ->            2
QTR13.     ->             2
QTR14.     ->              2
QTR15.     ->               2
QTR16.     ->                2
QTR17.     ->                 2
QTR18.     ->                  2
QTR19.     ->                   2
QTR20.     ->                    2
QTR21.     ->                     2
QTR22.     ->                      2
QTR23.     ->                       2
QTR24.     ->                        2
QTR25.     ->                         2
QTR26.     ->                          2
QTR27.     ->                           2
QTR28.     ->                            2
QTR29.     ->                             2
QTR30.     ->                              2
QTR31.     ->                               2
QTR32.     ->                                2

QTRR.      ->  II
QTRR3.     ->  II
QTRR4.     ->   II
QTRR5.     ->    II
QTRR6.     ->     II
QTRR7.     ->      II
QTRR8.     ->       II
QTRR9.     ->        II
QTRR10.    ->         II
QTRR11.    ->          II
QTRR12.    ->           II
QTRR13.    ->            II
QTRR14.    ->             II
QTRR15.    ->              II
QTRR16.    ->               II
QTRR17.    ->                II
QTRR18.    ->                 II
QTRR19.    ->                  II
QTRR20.    ->                   II
QTRR21.    ->                    II
QTRR22.    ->                     II
QTRR23.    ->                      II
QTRR24.    ->                       II
QTRR25.    ->                        II
QTRR26.    ->                         II
QTRR27.    ->                          II
QTRR28.    ->                           II
QTRR29.    ->                            II
QTRR30.    ->                             II
QTRR31.    ->                              II
QTRR32.    ->                               II

WEEKDATE.  ->        Saturday, May 14, 2022
WEEKDATE3. -> Sat
WEEKDATE4. ->  Sat
WEEKDATE5. ->   Sat
WEEKDATE6. ->    Sat
WEEKDATE7. ->     Sat
WEEKDATE8. ->      Sat
WEEKDATE9. ->  Saturday
WEEKDATE10.->   Saturday
WEEKDATE11.->    Saturday
WEEKDATE12.->     Saturday
WEEKDATE13.->      Saturday
WEEKDATE14.->       Saturday
WEEKDATE15.-> Sat, May 14, 22
WEEKDATE16.->  Sat, May 14, 22
WEEKDATE17.-> Sat, May 14, 2022
WEEKDATE18.->  Sat, May 14, 2022
WEEKDATE19.->   Sat, May 14, 2022
WEEKDATE20.->    Sat, May 14, 2022
WEEKDATE21.->     Sat, May 14, 2022
WEEKDATE22.->      Sat, May 14, 2022
WEEKDATE23.->  Saturday, May 14, 2022
WEEKDATE24.->   Saturday, May 14, 2022
WEEKDATE25.->    Saturday, May 14, 2022
WEEKDATE26.->     Saturday, May 14, 2022
WEEKDATE27.->      Saturday, May 14, 2022
WEEKDATE28.->       Saturday, May 14, 2022
WEEKDATE29.->        Saturday, May 14, 2022
WEEKDATE30.->         Saturday, May 14, 2022
WEEKDATE31.->          Saturday, May 14, 2022
WEEKDATE32.->           Saturday, May 14, 2022
WEEKDATE33.->            Saturday, May 14, 2022
WEEKDATE34.->             Saturday, May 14, 2022
WEEKDATE35.->              Saturday, May 14, 2022
WEEKDATE36.->               Saturday, May 14, 2022
WEEKDATE37.->                Saturday, May 14, 2022

WEEKDATX.  ->         Saturday, 14 May 2022
WEEKDATX3. -> Sat
WEEKDATX4. ->  Sat
WEEKDATX5. ->   Sat
WEEKDATX6. ->    Sat
WEEKDATX7. ->     Sat
WEEKDATX8. ->      Sat
WEEKDATX9. ->  Saturday
WEEKDATX10.->   Saturday
WEEKDATX11.->    Saturday
WEEKDATX12.->     Saturday
WEEKDATX13.->      Saturday
WEEKDATX14.->       Saturday
WEEKDATX15.->  Sat, 14 May 22
WEEKDATX16.->   Sat, 14 May 22
WEEKDATX17.->  Sat, 14 May 2022
WEEKDATX18.->   Sat, 14 May 2022
WEEKDATX19.->    Sat, 14 May 2022
WEEKDATX20.->     Sat, 14 May 2022
WEEKDATX21.->      Sat, 14 May 2022
WEEKDATX22.->       Sat, 14 May 2022
WEEKDATX23.->   Saturday, 14 May 2022
WEEKDATX24.->    Saturday, 14 May 2022
WEEKDATX25.->     Saturday, 14 May 2022
WEEKDATX26.->      Saturday, 14 May 2022
WEEKDATX27.->       Saturday, 14 May 2022
WEEKDATX28.->        Saturday, 14 May 2022
WEEKDATX29.->         Saturday, 14 May 2022
WEEKDATX30.->          Saturday, 14 May 2022
WEEKDATX31.->           Saturday, 14 May 2022
WEEKDATX32.->            Saturday, 14 May 2022
WEEKDATX33.->             Saturday, 14 May 2022
WEEKDATX34.->              Saturday, 14 May 2022
WEEKDATX35.->               Saturday, 14 May 2022
WEEKDATX36.->                Saturday, 14 May 2022
WEEKDATX37.->                 Saturday, 14 May 2022

WEEKDAY.   -> 7
WEEKDAY1.  -> 7
WEEKDAY2.  ->  7
WEEKDAY3.  ->   7
WEEKDAY4.  ->    7
WEEKDAY5.  ->     7
WEEKDAY6.  ->      7
WEEKDAY7.  ->       7
WEEKDAY8.  ->        7
WEEKDAY9.  ->         7
WEEKDAY10. ->          7
WEEKDAY11. ->           7
WEEKDAY12. ->            7
WEEKDAY13. ->             7
WEEKDAY14. ->              7
WEEKDAY15. ->               7
WEEKDAY16. ->                7
WEEKDAY17. ->                 7
WEEKDAY18. ->                  7
WEEKDAY19. ->                   7
WEEKDAY20. ->                    7
WEEKDAY21. ->                     7
WEEKDAY22. ->                      7
WEEKDAY23. ->                       7
WEEKDAY24. ->                        7
WEEKDAY25. ->                         7
WEEKDAY26. ->                          7
WEEKDAY27. ->                           7
WEEKDAY28. ->                            7
WEEKDAY29. ->                             7
WEEKDAY30. ->                              7
WEEKDAY31. ->                               7
WEEKDAY32. ->                                7

WORDDATE.  ->       May 14, 2022
WORDDATE3. -> May
WORDDATE4. ->  May
WORDDATE5. ->   May
WORDDATE6. ->    May
WORDDATE7. ->     May
WORDDATE8. ->      May
WORDDATE9. ->       May
WORDDATE10.->        May
WORDDATE11.->         May
WORDDATE12.-> May 14, 2022
WORDDATE13.->  May 14, 2022
WORDDATE14.->   May 14, 2022
WORDDATE15.->    May 14, 2022
WORDDATE16.->     May 14, 2022
WORDDATE17.->      May 14, 2022
WORDDATE18.->       May 14, 2022
WORDDATE19.->        May 14, 2022
WORDDATE20.->         May 14, 2022
WORDDATE21.->          May 14, 2022
WORDDATE22.->           May 14, 2022
WORDDATE23.->            May 14, 2022
WORDDATE24.->             May 14, 2022
WORDDATE25.->              May 14, 2022
WORDDATE26.->               May 14, 2022
WORDDATE27.->                May 14, 2022
WORDDATE28.->                 May 14, 2022
WORDDATE29.->                  May 14, 2022
WORDDATE30.->                   May 14, 2022
WORDDATE31.->                    May 14, 2022
WORDDATE32.->                     May 14, 2022

WORDDATX.  ->        14 May 2022
WORDDATX3. -> May
WORDDATX4. ->  May
WORDDATX5. ->   May
WORDDATX6. ->    May
WORDDATX7. ->     May
WORDDATX8. ->      May
WORDDATX9. ->       May
WORDDATX10.->        May
WORDDATX11.->         May
WORDDATX12.->  14 May 2022
WORDDATX13.->   14 May 2022
WORDDATX14.->    14 May 2022
WORDDATX15.->     14 May 2022
WORDDATX16.->      14 May 2022
WORDDATX17.->       14 May 2022
WORDDATX18.->        14 May 2022
WORDDATX19.->         14 May 2022
WORDDATX20.->          14 May 2022
WORDDATX21.->           14 May 2022
WORDDATX22.->            14 May 2022
WORDDATX23.->             14 May 2022
WORDDATX24.->              14 May 2022
WORDDATX25.->               14 May 2022
WORDDATX26.->                14 May 2022
WORDDATX27.->                 14 May 2022
WORDDATX28.->                  14 May 2022
WORDDATX29.->                   14 May 2022
WORDDATX30.->                    14 May 2022
WORDDATX31.->                     14 May 2022
WORDDATX32.->                      14 May 2022

YEAR.      -> 2022
YEAR2.     -> 22
YEAR3.     ->  22
YEAR4.     -> 2022
YEAR5.     ->  2022
YEAR6.     ->   2022
YEAR7.     ->    2022
YEAR8.     ->     2022
YEAR9.     ->      2022
YEAR10.    ->       2022
YEAR11.    ->        2022
YEAR12.    ->         2022
YEAR13.    ->          2022
YEAR14.    ->           2022
YEAR15.    ->            2022
YEAR16.    ->             2022
YEAR17.    ->              2022
YEAR18.    ->               2022
YEAR19.    ->                2022
YEAR20.    ->                 2022
YEAR21.    ->                  2022
YEAR22.    ->                   2022
YEAR23.    ->                    2022
YEAR24.    ->                     2022
YEAR25.    ->                      2022
YEAR26.    ->                       2022
YEAR27.    ->                        2022
YEAR28.    ->                         2022
YEAR29.    ->                          2022
YEAR30.    ->                           2022
YEAR31.    ->                            2022
YEAR32.    ->                             2022

YYMM.      -> 2022M05
YYMM5.     -> 22M05
YYMM6.     ->  22M05
YYMM7.     -> 2022M05
YYMM8.     ->  2022M05
YYMM9.     ->   2022M05
YYMM10.    ->    2022M05
YYMM11.    ->     2022M05
YYMM12.    ->      2022M05
YYMM13.    ->       2022M05
YYMM14.    ->        2022M05
YYMM15.    ->         2022M05
YYMM16.    ->          2022M05
YYMM17.    ->           2022M05
YYMM18.    ->            2022M05
YYMM19.    ->             2022M05
YYMM20.    ->              2022M05
YYMM21.    ->               2022M05
YYMM22.    ->                2022M05
YYMM23.    ->                 2022M05
YYMM24.    ->                  2022M05
YYMM25.    ->                   2022M05
YYMM26.    ->                    2022M05
YYMM27.    ->                     2022M05
YYMM28.    ->                      2022M05
YYMM29.    ->                       2022M05
YYMM30.    ->                        2022M05
YYMM31.    ->                         2022M05
YYMM32.    ->                          2022M05

YYMM.      -> 2022M05
YYMMC5.    -> 22:05
YYMMC6.    ->  22:05
YYMMC7.    -> 2022:05
YYMMC8.    ->  2022:05
YYMMC9.    ->   2022:05
YYMMC10.   ->    2022:05
YYMMC11.   ->     2022:05
YYMMC12.   ->      2022:05
YYMMC13.   ->       2022:05
YYMMC14.   ->        2022:05
YYMMC15.   ->         2022:05
YYMMC16.   ->          2022:05
YYMMC17.   ->           2022:05
YYMMC18.   ->            2022:05
YYMMC19.   ->             2022:05
YYMMC20.   ->              2022:05
YYMMC21.   ->               2022:05
YYMMC22.   ->                2022:05
YYMMC23.   ->                 2022:05
YYMMC24.   ->                  2022:05
YYMMC25.   ->                   2022:05
YYMMC26.   ->                    2022:05
YYMMC27.   ->                     2022:05
YYMMC28.   ->                      2022:05
YYMMC29.   ->                       2022:05
YYMMC30.   ->                        2022:05
YYMMC31.   ->                         2022:05
YYMMC32.   ->                          2022:05
YYMMD5.    -> 22-05
YYMMD6.    ->  22-05
YYMMD7.    -> 2022-05
YYMMD8.    ->  2022-05
YYMMD9.    ->   2022-05
YYMMD10.   ->    2022-05
YYMMD11.   ->     2022-05
YYMMD12.   ->      2022-05
YYMMD13.   ->       2022-05
YYMMD14.   ->        2022-05
YYMMD15.   ->         2022-05
YYMMD16.   ->          2022-05
YYMMD17.   ->           2022-05
YYMMD18.   ->            2022-05
YYMMD19.   ->             2022-05
YYMMD20.   ->              2022-05
YYMMD21.   ->               2022-05
YYMMD22.   ->                2022-05
YYMMD23.   ->                 2022-05
YYMMD24.   ->                  2022-05
YYMMD25.   ->                   2022-05
YYMMD26.   ->                    2022-05
YYMMD27.   ->                     2022-05
YYMMD28.   ->                      2022-05
YYMMD29.   ->                       2022-05
YYMMD30.   ->                        2022-05
YYMMD31.   ->                         2022-05
YYMMD32.   ->                          2022-05
YYMMN5.    ->  2205
YYMMN6.    -> 202205
YYMMN7.    ->  202205
YYMMN8.    ->   202205
YYMMN9.    ->    202205
YYMMN10.   ->     202205
YYMMN11.   ->      202205
YYMMN12.   ->       202205
YYMMN13.   ->        202205
YYMMN14.   ->         202205
YYMMN15.   ->          202205
YYMMN16.   ->           202205
YYMMN17.   ->            202205
YYMMN18.   ->             202205
YYMMN19.   ->              202205
YYMMN20.   ->               202205
YYMMN21.   ->                202205
YYMMN22.   ->                 202205
YYMMN23.   ->                  202205
YYMMN24.   ->                   202205
YYMMN25.   ->                    202205
YYMMN26.   ->                     202205
YYMMN27.   ->                      202205
YYMMN28.   ->                       202205
YYMMN29.   ->                        202205
YYMMN30.   ->                         202205
YYMMN31.   ->                          202205
YYMMN32.   ->                           202205
YYMMP5.    -> 22.05
YYMMP6.    ->  22.05
YYMMP7.    -> 2022.05
YYMMP8.    ->  2022.05
YYMMP9.    ->   2022.05
YYMMP10.   ->    2022.05
YYMMP11.   ->     2022.05
YYMMP12.   ->      2022.05
YYMMP13.   ->       2022.05
YYMMP14.   ->        2022.05
YYMMP15.   ->         2022.05
YYMMP16.   ->          2022.05
YYMMP17.   ->           2022.05
YYMMP18.   ->            2022.05
YYMMP19.   ->             2022.05
YYMMP20.   ->              2022.05
YYMMP21.   ->               2022.05
YYMMP22.   ->                2022.05
YYMMP23.   ->                 2022.05
YYMMP24.   ->                  2022.05
YYMMP25.   ->                   2022.05
YYMMP26.   ->                    2022.05
YYMMP27.   ->                     2022.05
YYMMP28.   ->                      2022.05
YYMMP29.   ->                       2022.05
YYMMP30.   ->                        2022.05
YYMMP31.   ->                         2022.05
YYMMP32.   ->                          2022.05
YYMMS5.    -> 22/05
YYMMS6.    ->  22/05
YYMMS7.    -> 2022/05
YYMMS8.    ->  2022/05
YYMMS9.    ->   2022/05
YYMMS10.   ->    2022/05
YYMMS11.   ->     2022/05
YYMMS12.   ->      2022/05
YYMMS13.   ->       2022/05
YYMMS14.   ->        2022/05
YYMMS15.   ->         2022/05
YYMMS16.   ->          2022/05
YYMMS17.   ->           2022/05
YYMMS18.   ->            2022/05
YYMMS19.   ->             2022/05
YYMMS20.   ->              2022/05
YYMMS21.   ->               2022/05
YYMMS22.   ->                2022/05
YYMMS23.   ->                 2022/05
YYMMS24.   ->                  2022/05
YYMMS25.   ->                   2022/05
YYMMS26.   ->                    2022/05
YYMMS27.   ->                     2022/05
YYMMS28.   ->                      2022/05
YYMMS29.   ->                       2022/05
YYMMS30.   ->                        2022/05
YYMMS31.   ->                         2022/05
YYMMS32.   ->                          2022/05

YYMMDD.    -> 22-05-14
YYMMDD2.   -> 22
YYMMDD3.   ->  22
YYMMDD4.   -> 2205
YYMMDD5.   -> 22-05
YYMMDD6.   -> 220514
YYMMDD7.   ->  220514
YYMMDD8.   -> 22-05-14

YYMMDD.    -> 22-05-14
YYMMDDB2.  -> 22
YYMMDDB3.  ->  22
YYMMDDB4.  -> 2205
YYMMDDB5.  -> 22 05
YYMMDDB6.  -> 220514
YYMMDDB7.  ->  220514
YYMMDDB8.  -> 22 05 14
YYMMDDB9.  ->  22 05 14
YYMMDDB10. -> 2022 05 14
YYMMDDC2.  -> 22
YYMMDDC3.  ->  22
YYMMDDC4.  -> 2205
YYMMDDC5.  -> 22:05
YYMMDDC6.  -> 220514
YYMMDDC7.  ->  220514
YYMMDDC8.  -> 22:05:14
YYMMDDC9.  ->  22:05:14
YYMMDDC10. -> 2022:05:14
YYMMDDD2.  -> 22
YYMMDDD3.  ->  22
YYMMDDD4.  -> 2205
YYMMDDD5.  -> 22-05
YYMMDDD6.  -> 220514
YYMMDDD7.  ->  220514
YYMMDDD8.  -> 22-05-14
YYMMDDD9.  ->  22-05-14
YYMMDDD10. -> 2022-05-14
YYMMDDN2.  -> 22
YYMMDDN3.  ->  22
YYMMDDN4.  -> 2205
YYMMDDN5.  ->  2205
YYMMDDN6.  -> 220514
YYMMDDN7.  ->  220514
YYMMDDN8.  -> 20220514
YYMMDDP2.  -> 22
YYMMDDP3.  ->  22
YYMMDDP4.  -> 2205
YYMMDDP5.  -> 22.05
YYMMDDP6.  -> 220514
YYMMDDP7.  ->  220514
YYMMDDP8.  -> 22.05.14
YYMMDDP9.  ->  22.05.14
YYMMDDP10. -> 2022.05.14
YYMMDDS2.  -> 22
YYMMDDS3.  ->  22
YYMMDDS4.  -> 2205
YYMMDDS5.  -> 22/05
YYMMDDS6.  -> 220514
YYMMDDS7.  ->  220514
YYMMDDS8.  -> 22/05/14
YYMMDDS9.  ->  22/05/14
YYMMDDS10. -> 2022/05/14

YYMON.     -> 2022MAY
YYMON5.    -> 22MAY
YYMON6.    ->  22MAY
YYMON7.    -> 2022MAY
YYMON8.    ->  2022MAY
YYMON9.    ->   2022MAY
YYMON10.   ->    2022MAY
YYMON11.   ->     2022MAY
YYMON12.   ->      2022MAY
YYMON13.   ->       2022MAY
YYMON14.   ->        2022MAY
YYMON15.   ->         2022MAY
YYMON16.   ->          2022MAY
YYMON17.   ->           2022MAY
YYMON18.   ->            2022MAY
YYMON19.   ->             2022MAY
YYMON20.   ->              2022MAY
YYMON21.   ->               2022MAY
YYMON22.   ->                2022MAY
YYMON23.   ->                 2022MAY
YYMON24.   ->                  2022MAY
YYMON25.   ->                   2022MAY
YYMON26.   ->                    2022MAY
YYMON27.   ->                     2022MAY
YYMON28.   ->                      2022MAY
YYMON29.   ->                       2022MAY
YYMON30.   ->                        2022MAY
YYMON31.   ->                         2022MAY
YYMON32.   ->                          2022MAY

YYQ.       -> 2022Q2
YYQ4.      -> 22Q2
YYQ5.      ->  22Q2
YYQ6.      -> 2022Q2
YYQ7.      ->  2022Q2
YYQ8.      ->   2022Q2
YYQ9.      ->    2022Q2
YYQ10.     ->     2022Q2
YYQ11.     ->      2022Q2
YYQ12.     ->       2022Q2
YYQ13.     ->        2022Q2
YYQ14.     ->         2022Q2
YYQ15.     ->          2022Q2
YYQ16.     ->           2022Q2
YYQ17.     ->            2022Q2
YYQ18.     ->             2022Q2
YYQ19.     ->              2022Q2
YYQ20.     ->               2022Q2
YYQ21.     ->                2022Q2
YYQ22.     ->                 2022Q2
YYQ23.     ->                  2022Q2
YYQ24.     ->                   2022Q2
YYQ25.     ->                    2022Q2
YYQ26.     ->                     2022Q2
YYQ27.     ->                      2022Q2
YYQ28.     ->                       2022Q2
YYQ29.     ->                        2022Q2
YYQ30.     ->                         2022Q2
YYQ31.     ->                          2022Q2
YYQ32.     ->                           2022Q2

YYQ.       -> 2022Q2
YYQC4.     -> 22:2
YYQC5.     ->  22:2
YYQC6.     -> 2022:2
YYQC7.     ->  2022:2
YYQC8.     ->   2022:2
YYQC9.     ->    2022:2
YYQC10.    ->     2022:2
YYQC11.    ->      2022:2
YYQC12.    ->       2022:2
YYQC13.    ->        2022:2
YYQC14.    ->         2022:2
YYQC15.    ->          2022:2
YYQC16.    ->           2022:2
YYQC17.    ->            2022:2
YYQC18.    ->             2022:2
YYQC19.    ->              2022:2
YYQC20.    ->               2022:2
YYQC21.    ->                2022:2
YYQC22.    ->                 2022:2
YYQC23.    ->                  2022:2
YYQC24.    ->                   2022:2
YYQC25.    ->                    2022:2
YYQC26.    ->                     2022:2
YYQC27.    ->                      2022:2
YYQC28.    ->                       2022:2
YYQC29.    ->                        2022:2
YYQC30.    ->                         2022:2
YYQC31.    ->                          2022:2
YYQC32.    ->                           2022:2
YYQD4.     -> 22-2
YYQD5.     ->  22-2
YYQD6.     -> 2022-2
YYQD7.     ->  2022-2
YYQD8.     ->   2022-2
YYQD9.     ->    2022-2
YYQD10.    ->     2022-2
YYQD11.    ->      2022-2
YYQD12.    ->       2022-2
YYQD13.    ->        2022-2
YYQD14.    ->         2022-2
YYQD15.    ->          2022-2
YYQD16.    ->           2022-2
YYQD17.    ->            2022-2
YYQD18.    ->             2022-2
YYQD19.    ->              2022-2
YYQD20.    ->               2022-2
YYQD21.    ->                2022-2
YYQD22.    ->                 2022-2
YYQD23.    ->                  2022-2
YYQD24.    ->                   2022-2
YYQD25.    ->                    2022-2
YYQD26.    ->                     2022-2
YYQD27.    ->                      2022-2
YYQD28.    ->                       2022-2
YYQD29.    ->                        2022-2
YYQD30.    ->                         2022-2
YYQD31.    ->                          2022-2
YYQD32.    ->                           2022-2
YYQN4.     ->  222
YYQN5.     -> 20222
YYQN6.     ->  20222
YYQN7.     ->   20222
YYQN8.     ->    20222
YYQN9.     ->     20222
YYQN10.    ->      20222
YYQN11.    ->       20222
YYQN12.    ->        20222
YYQN13.    ->         20222
YYQN14.    ->          20222
YYQN15.    ->           20222
YYQN16.    ->            20222
YYQN17.    ->             20222
YYQN18.    ->              20222
YYQN19.    ->               20222
YYQN20.    ->                20222
YYQN21.    ->                 20222
YYQN22.    ->                  20222
YYQN23.    ->                   20222
YYQN24.    ->                    20222
YYQN25.    ->                     20222
YYQN26.    ->                      20222
YYQN27.    ->                       20222
YYQN28.    ->                        20222
YYQN29.    ->                         20222
YYQN30.    ->                          20222
YYQN31.    ->                           20222
YYQN32.    ->                            20222
YYQP4.     -> 22.2
YYQP5.     ->  22.2
YYQP6.     -> 2022.2
YYQP7.     ->  2022.2
YYQP8.     ->   2022.2
YYQP9.     ->    2022.2
YYQP10.    ->     2022.2
YYQP11.    ->      2022.2
YYQP12.    ->       2022.2
YYQP13.    ->        2022.2
YYQP14.    ->         2022.2
YYQP15.    ->          2022.2
YYQP16.    ->           2022.2
YYQP17.    ->            2022.2
YYQP18.    ->             2022.2
YYQP19.    ->              2022.2
YYQP20.    ->               2022.2
YYQP21.    ->                2022.2
YYQP22.    ->                 2022.2
YYQP23.    ->                  2022.2
YYQP24.    ->                   2022.2
YYQP25.    ->                    2022.2
YYQP26.    ->                     2022.2
YYQP27.    ->                      2022.2
YYQP28.    ->                       2022.2
YYQP29.    ->                        2022.2
YYQP30.    ->                         2022.2
YYQP31.    ->                          2022.2
YYQP32.    ->                           2022.2
YYQS4.     -> 22/2
YYQS5.     ->  22/2
YYQS6.     -> 2022/2
YYQS7.     ->  2022/2
YYQS8.     ->   2022/2
YYQS9.     ->    2022/2
YYQS10.    ->     2022/2
YYQS11.    ->      2022/2
YYQS12.    ->       2022/2
YYQS13.    ->        2022/2
YYQS14.    ->         2022/2
YYQS15.    ->          2022/2
YYQS16.    ->           2022/2
YYQS17.    ->            2022/2
YYQS18.    ->             2022/2
YYQS19.    ->              2022/2
YYQS20.    ->               2022/2
YYQS21.    ->                2022/2
YYQS22.    ->                 2022/2
YYQS23.    ->                  2022/2
YYQS24.    ->                   2022/2
YYQS25.    ->                    2022/2
YYQS26.    ->                     2022/2
YYQS27.    ->                      2022/2
YYQS28.    ->                       2022/2
YYQS29.    ->                        2022/2
YYQS30.    ->                         2022/2
YYQS31.    ->                          2022/2
YYQS32.    ->                           2022/2

YYQR.      ->  2022QII
YYQR6.     ->  22QII
YYQR7.     -> 2022QII
YYQR8.     ->  2022QII
YYQR9.     ->   2022QII
YYQR10.    ->    2022QII
YYQR11.    ->     2022QII
YYQR12.    ->      2022QII
YYQR13.    ->       2022QII
YYQR14.    ->        2022QII
YYQR15.    ->         2022QII
YYQR16.    ->          2022QII
YYQR17.    ->           2022QII
YYQR18.    ->            2022QII
YYQR19.    ->             2022QII
YYQR20.    ->              2022QII
YYQR21.    ->               2022QII
YYQR22.    ->                2022QII
YYQR23.    ->                 2022QII
YYQR24.    ->                  2022QII
YYQR25.    ->                   2022QII
YYQR26.    ->                    2022QII
YYQR27.    ->                     2022QII
YYQR28.    ->                      2022QII
YYQR29.    ->                       2022QII
YYQR30.    ->                        2022QII
YYQR31.    ->                         2022QII
YYQR32.    ->                          2022QII

YYQR.      ->  2022QII
YYQRC6.    ->  22:II
YYQRC7.    -> 2022:II
YYQRC8.    ->  2022:II
YYQRC9.    ->   2022:II
YYQRC10.   ->    2022:II
YYQRC11.   ->     2022:II
YYQRC12.   ->      2022:II
YYQRC13.   ->       2022:II
YYQRC14.   ->        2022:II
YYQRC15.   ->         2022:II
YYQRC16.   ->          2022:II
YYQRC17.   ->           2022:II
YYQRC18.   ->            2022:II
YYQRC19.   ->             2022:II
YYQRC20.   ->              2022:II
YYQRC21.   ->               2022:II
YYQRC22.   ->                2022:II
YYQRC23.   ->                 2022:II
YYQRC24.   ->                  2022:II
YYQRC25.   ->                   2022:II
YYQRC26.   ->                    2022:II
YYQRC27.   ->                     2022:II
YYQRC28.   ->                      2022:II
YYQRC29.   ->                       2022:II
YYQRC30.   ->                        2022:II
YYQRC31.   ->                         2022:II
YYQRC32.   ->                          2022:II
YYQRD6.    ->  22-II
YYQRD7.    -> 2022-II
YYQRD8.    ->  2022-II
YYQRD9.    ->   2022-II
YYQRD10.   ->    2022-II
YYQRD11.   ->     2022-II
YYQRD12.   ->      2022-II
YYQRD13.   ->       2022-II
YYQRD14.   ->        2022-II
YYQRD15.   ->         2022-II
YYQRD16.   ->          2022-II
YYQRD17.   ->           2022-II
YYQRD18.   ->            2022-II
YYQRD19.   ->             2022-II
YYQRD20.   ->              2022-II
YYQRD21.   ->               2022-II
YYQRD22.   ->                2022-II
YYQRD23.   ->                 2022-II
YYQRD24.   ->                  2022-II
YYQRD25.   ->                   2022-II
YYQRD26.   ->                    2022-II
YYQRD27.   ->                     2022-II
YYQRD28.   ->                      2022-II
YYQRD29.   ->                       2022-II
YYQRD30.   ->                        2022-II
YYQRD31.   ->                         2022-II
YYQRD32.   ->                          2022-II
YYQRN6.    -> 2022II
YYQRN7.    ->  2022II
YYQRN8.    ->   2022II
YYQRN9.    ->    2022II
YYQRN10.   ->     2022II
YYQRN11.   ->      2022II
YYQRN12.   ->       2022II
YYQRN13.   ->        2022II
YYQRN14.   ->         2022II
YYQRN15.   ->          2022II
YYQRN16.   ->           2022II
YYQRN17.   ->            2022II
YYQRN18.   ->             2022II
YYQRN19.   ->              2022II
YYQRN20.   ->               2022II
YYQRN21.   ->                2022II
YYQRN22.   ->                 2022II
YYQRN23.   ->                  2022II
YYQRN24.   ->                   2022II
YYQRN25.   ->                    2022II
YYQRN26.   ->                     2022II
YYQRN27.   ->                      2022II
YYQRN28.   ->                       2022II
YYQRN29.   ->                        2022II
YYQRN30.   ->                         2022II
YYQRN31.   ->                          2022II
YYQRN32.   ->                           2022II
YYQRP6.    ->  22.II
YYQRP7.    -> 2022.II
YYQRP8.    ->  2022.II
YYQRP9.    ->   2022.II
YYQRP10.   ->    2022.II
YYQRP11.   ->     2022.II
YYQRP12.   ->      2022.II
YYQRP13.   ->       2022.II
YYQRP14.   ->        2022.II
YYQRP15.   ->         2022.II
YYQRP16.   ->          2022.II
YYQRP17.   ->           2022.II
YYQRP18.   ->            2022.II
YYQRP19.   ->             2022.II
YYQRP20.   ->              2022.II
YYQRP21.   ->               2022.II
YYQRP22.   ->                2022.II
YYQRP23.   ->                 2022.II
YYQRP24.   ->                  2022.II
YYQRP25.   ->                   2022.II
YYQRP26.   ->                    2022.II
YYQRP27.   ->                     2022.II
YYQRP28.   ->                      2022.II
YYQRP29.   ->                       2022.II
YYQRP30.   ->                        2022.II
YYQRP31.   ->                         2022.II
YYQRP32.   ->                          2022.II
YYQRS6.    ->  22/II
YYQRS7.    -> 2022/II
YYQRS8.    ->  2022/II
YYQRS9.    ->   2022/II
YYQRS10.   ->    2022/II
YYQRS11.   ->     2022/II
YYQRS12.   ->      2022/II
YYQRS13.   ->       2022/II
YYQRS14.   ->        2022/II
YYQRS15.   ->         2022/II
YYQRS16.   ->          2022/II
YYQRS17.   ->           2022/II
YYQRS18.   ->            2022/II
YYQRS19.   ->             2022/II
YYQRS20.   ->              2022/II
YYQRS21.   ->               2022/II
YYQRS22.   ->                2022/II
YYQRS23.   ->                 2022/II
YYQRS24.   ->                  2022/II
YYQRS25.   ->                   2022/II
YYQRS26.   ->                    2022/II
YYQRS27.   ->                     2022/II
YYQRS28.   ->                      2022/II
YYQRS29.   ->                       2022/II
YYQRS30.   ->                        2022/II
YYQRS31.   ->                         2022/II
YYQRS32.   ->                          2022/II
;;;;
run;quit;
