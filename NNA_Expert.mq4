//+------------------------------------------------------------------+
//|                                                   NNA_Expert.mq4 |
//|                        Copyright 2018, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2018, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+


//---------- VARIABLES ---------------------------------------------

#define SW_HIDE             0
#define SW_SHOWNORMAL       1
#define SW_NORMAL           1
#define SW_SHOWMINIMIZED    2
#define SW_SHOWMAXIMIZED    3
#define SW_MAXIMIZE         3
#define SW_SHOWNOACTIVATE   4
#define SW_SHOW             5
#define SW_MINIMIZE         6
#define SW_SHOWMINNOACTIVE  7
#define SW_SHOWNA           8
#define SW_RESTORE          9
#define SW_SHOWDEFAULT      10
#define SW_FORCEMINIMIZE    11
#define SW_MAX              11

#import "shell32.dll"
int ShellExecuteW(int hWnd,int lpVerb,string lpFile,int lpParameters,int lpDirectory,int nCmdShow);
#import

static datetime lastbar;
extern string MarketPrefix="";
string terminal_data_path=TerminalInfoString(TERMINAL_COMMONDATA_PATH); 
double Data[14,27];
int filehandle,filehandle_answer;
string Answer[250];
double A_R=-1;

extern double LOTS=0.1;
//------------------------------------------------------------------

int OnInit()
  {
//---
GlobalVariableSet("Answer_read",0); 
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---
   
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
 //    My_print("Next Candel Time : "+TimeToStr(TimeCurrent(),TIME_SECONDS),240,200 , "44" , 20);
//---Be name davare bar hagh - bakhshandeye bozorg - be name khodavande isar va ensaf
bool e=GlobalVariableGet("Answer_read",A_R);
if (A_R==1) Answer_read();
double Answer_read_check;
GlobalVariableGet("Answer_read",Answer_read_check);
if (isNewBar() && Answer_read_check==0)
  {
      Data_generator();
      FileDelete("Answer.txt",FILE_COMMON|FILE_CSV);
      GlobalVariableSet("Answer_read",1);  
      ShellExecuteW(0,0,terminal_data_path+"\\files\\"+"NNA.bat","",0,SW_HIDE);
  
  }
Close_orders();
  }
  
//+---------------------------------------------------------------------------+
bool isNewBar() 
{ 
   datetime curbar = Time[0]; 
   if(lastbar!=curbar) 
   { 
      lastbar=curbar; 
      return (true); 
   }    
   else 
   { 
      return(false); 
   } 
}   

//------------------------------------------------------------------------------

void Data_generator()
{

//2   1  EURUSD 
//3   2  EURAUD 
//4   3  EURCAD 
//5   4  EURCHF 
//6   5  EURGBP 
//7   6  EURJPY
//8   7  EURNZD 
//9   8  AUDUSD 
//10  9  USDCAD 
//11  10 USDCHF
//12  11 GBPUSD
//13  12 USDJPY
//14  13 NZDUSD

for(int p=0;p<=26;p++)
{
for(int k=0;k<=13;k++)
{
Data[k,p]=0;
}
}
Data_fill(1,"EURUSD");
Data_fill(2,"EURAUD");
Data_fill(3,"EURCAD");
Data_fill(4,"EURCHF");
Data_fill(5,"EURGBP");
Data_fill(6,"EURJPY");
Data_fill(7,"EURNZD");
Data_fill(8,"AUDUSD");
Data_fill(9,"USDCAD");
Data_fill(10,"USDCHF");
Data_fill(11,"GBPUSD");
Data_fill(12,"USDJPY");
Data_fill(13,"NZDUSD");

filehandle=FileOpen("Data"+".csv",FILE_WRITE|FILE_COMMON|FILE_CSV); 
for (int i=1;i<=13;i++)
  {
         if(filehandle!=INVALID_HANDLE) 
            { 
               FileWrite(filehandle,(DoubleToStr(Data[i,1],10))+","+(DoubleToStr(Data[i,2],10))+","+(DoubleToStr(Data[i,3],10))+","+(DoubleToStr(Data[i,4],10))+","+(DoubleToStr(Data[i,5],10))+","+(DoubleToStr(Data[i,6],10))+","+(DoubleToStr(Data[i,7],10))+","+(DoubleToStr(Data[i,8],10))+","+(DoubleToStr(Data[i,9],10))+","+(DoubleToStr(Data[i,10],10))+","+(DoubleToStr(Data[i,11],10))+","+(DoubleToStr(Data[i,12],10))+","+(DoubleToStr(Data[i,13],10))+","+(DoubleToStr(Data[i,14],10))+","+(DoubleToStr(Data[i,15],10))+","+(DoubleToStr(Data[i,16],10))+","+(DoubleToStr(Data[i,17],10))+","+(DoubleToStr(Data[i,18],10))+","+(DoubleToStr(Data[i,19],10))+","+(DoubleToStr(Data[i,20],10))+","+(DoubleToStr(Data[i,21],10))+","+(DoubleToStr(Data[i,22],10))+","+(DoubleToStr(Data[i,23],10))+","+(DoubleToStr(Data[i,24],10))+","+(DoubleToStr(Data[i,25],10))+","+(DoubleToStr(Data[i,26],10))); 
            }
  }  
    FileClose(filehandle);
}
//--------------------------------------------------------------------------------
void Data_fill(int x,string symbol)
{

if(iTime(Symbol(),1,1)==iTime(symbol+MarketPrefix,1,1))
{
//15m-30m-1h-2h-3h-4h-5h-6h-7h-8h-9h-10h-11h-12h-13h-14h-15h-16h-17h-18h-19h-20h-21h-22h-23h-1d
Data[x,1]=iClose(symbol+MarketPrefix,1,1)-iClose(symbol+MarketPrefix,1,15);
Data[x,2]=iClose(symbol+MarketPrefix,1,1)-iClose(symbol+MarketPrefix,1,30);
Data[x,3]=iClose(symbol+MarketPrefix,1,1)-iClose(symbol+MarketPrefix,1,60);
Data[x,4]=iClose(symbol+MarketPrefix,1,1)-iClose(symbol+MarketPrefix,1,120);
Data[x,5]=iClose(symbol+MarketPrefix,1,1)-iClose(symbol+MarketPrefix,1,180);
Data[x,6]=iClose(symbol+MarketPrefix,1,1)-iClose(symbol+MarketPrefix,1,240);
Data[x,7]=iClose(symbol+MarketPrefix,1,1)-iClose(symbol+MarketPrefix,1,300);
Data[x,8]=iClose(symbol+MarketPrefix,1,1)-iClose(symbol+MarketPrefix,1,360);
Data[x,9]=iClose(symbol+MarketPrefix,1,1)-iClose(symbol+MarketPrefix,1,420);
Data[x,10]=iClose(symbol+MarketPrefix,1,1)-iClose(symbol+MarketPrefix,1,480);
Data[x,11]=iClose(symbol+MarketPrefix,1,1)-iClose(symbol+MarketPrefix,1,540);
Data[x,12]=iClose(symbol+MarketPrefix,1,1)-iClose(symbol+MarketPrefix,1,600);
Data[x,13]=iClose(symbol+MarketPrefix,1,1)-iClose(symbol+MarketPrefix,1,660);
Data[x,14]=iClose(symbol+MarketPrefix,1,1)-iClose(symbol+MarketPrefix,1,720);
Data[x,15]=iClose(symbol+MarketPrefix,1,1)-iClose(symbol+MarketPrefix,1,780);
Data[x,16]=iClose(symbol+MarketPrefix,1,1)-iClose(symbol+MarketPrefix,1,840);
Data[x,17]=iClose(symbol+MarketPrefix,1,1)-iClose(symbol+MarketPrefix,1,900);
Data[x,18]=iClose(symbol+MarketPrefix,1,1)-iClose(symbol+MarketPrefix,1,960);
Data[x,19]=iClose(symbol+MarketPrefix,1,1)-iClose(symbol+MarketPrefix,1,1020);
Data[x,20]=iClose(symbol+MarketPrefix,1,1)-iClose(symbol+MarketPrefix,1,1080);
Data[x,21]=iClose(symbol+MarketPrefix,1,1)-iClose(symbol+MarketPrefix,1,1140);
Data[x,22]=iClose(symbol+MarketPrefix,1,1)-iClose(symbol+MarketPrefix,1,1200);
Data[x,23]=iClose(symbol+MarketPrefix,1,1)-iClose(symbol+MarketPrefix,1,1260);
Data[x,24]=iClose(symbol+MarketPrefix,1,1)-iClose(symbol+MarketPrefix,1,1320);
Data[x,25]=iClose(symbol+MarketPrefix,1,1)-iClose(symbol+MarketPrefix,1,1380);
Data[x,26]=iClose(symbol+MarketPrefix,1,1)-iClose(symbol+MarketPrefix,1,1440);
}
if(iTime(Symbol(),1,1)!=iTime(symbol+MarketPrefix,1,1))
{
//15m-30m-1h-2h-3h-4h-5h-6h-7h-8h-9h-10h-11h-12h-13h-14h-15h-16h-17h-18h-19h-20h-21h-22h-23h-1d
Data[x,1]=MarketInfo(symbol+MarketPrefix,MODE_BID)-iClose(symbol+MarketPrefix,1,14);
Data[x,2]=MarketInfo(symbol+MarketPrefix,MODE_BID)-iClose(symbol+MarketPrefix,1,29);
Data[x,3]=MarketInfo(symbol+MarketPrefix,MODE_BID)-iClose(symbol+MarketPrefix,1,59);
Data[x,4]=MarketInfo(symbol+MarketPrefix,MODE_BID)-iClose(symbol+MarketPrefix,1,119);
Data[x,5]=MarketInfo(symbol+MarketPrefix,MODE_BID)-iClose(symbol+MarketPrefix,1,179);
Data[x,6]=MarketInfo(symbol+MarketPrefix,MODE_BID)-iClose(symbol+MarketPrefix,1,239);
Data[x,7]=MarketInfo(symbol+MarketPrefix,MODE_BID)-iClose(symbol+MarketPrefix,1,299);
Data[x,8]=MarketInfo(symbol+MarketPrefix,MODE_BID)-iClose(symbol+MarketPrefix,1,359);
Data[x,9]=MarketInfo(symbol+MarketPrefix,MODE_BID)-iClose(symbol+MarketPrefix,1,419);
Data[x,10]=MarketInfo(symbol+MarketPrefix,MODE_BID)-iClose(symbol+MarketPrefix,1,479);
Data[x,11]=MarketInfo(symbol+MarketPrefix,MODE_BID)-iClose(symbol+MarketPrefix,1,539);
Data[x,12]=MarketInfo(symbol+MarketPrefix,MODE_BID)-iClose(symbol+MarketPrefix,1,599);
Data[x,13]=MarketInfo(symbol+MarketPrefix,MODE_BID)-iClose(symbol+MarketPrefix,1,659);
Data[x,14]=MarketInfo(symbol+MarketPrefix,MODE_BID)-iClose(symbol+MarketPrefix,1,719);
Data[x,15]=MarketInfo(symbol+MarketPrefix,MODE_BID)-iClose(symbol+MarketPrefix,1,779);
Data[x,16]=MarketInfo(symbol+MarketPrefix,MODE_BID)-iClose(symbol+MarketPrefix,1,839);
Data[x,17]=MarketInfo(symbol+MarketPrefix,MODE_BID)-iClose(symbol+MarketPrefix,1,899);
Data[x,18]=MarketInfo(symbol+MarketPrefix,MODE_BID)-iClose(symbol+MarketPrefix,1,959);
Data[x,19]=MarketInfo(symbol+MarketPrefix,MODE_BID)-iClose(symbol+MarketPrefix,1,1019);
Data[x,20]=MarketInfo(symbol+MarketPrefix,MODE_BID)-iClose(symbol+MarketPrefix,1,1079);
Data[x,21]=MarketInfo(symbol+MarketPrefix,MODE_BID)-iClose(symbol+MarketPrefix,1,1139);
Data[x,22]=MarketInfo(symbol+MarketPrefix,MODE_BID)-iClose(symbol+MarketPrefix,1,1199);
Data[x,23]=MarketInfo(symbol+MarketPrefix,MODE_BID)-iClose(symbol+MarketPrefix,1,1259);
Data[x,24]=MarketInfo(symbol+MarketPrefix,MODE_BID)-iClose(symbol+MarketPrefix,1,1319);
Data[x,25]=MarketInfo(symbol+MarketPrefix,MODE_BID)-iClose(symbol+MarketPrefix,1,1379);
Data[x,26]=MarketInfo(symbol+MarketPrefix,MODE_BID)-iClose(symbol+MarketPrefix,1,1439);
}
}
//-----------------------------------------------------------------------------------------------
void Close_orders()
{
   for (int i=OrdersTotal()-1;i>=0;i--)
               {
                   bool x=OrderSelect(i,SELECT_BY_POS,MODE_TRADES);
                   if(OrderOpenTime()+(OrderMagicNumber()*60)<=TimeCurrent())
                   {
                      bool c=OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),6,Gold);
                      if (OrderType()==OP_BUY)
                      {
                      SendNotification("Position BUY in "+OrderSymbol()+" at time frame "+IntegerToString(OrderMagicNumber())+" successfully Closed and Profit was :"+DoubleToStr(OrderProfit(),4));
                      }
                      if(OrderType()==OP_SELL)
                      {
                      SendNotification("Position SELL in "+OrderSymbol()+" at time frame "+IntegerToString(OrderMagicNumber())+" successfully Closed and Profit was :"+DoubleToStr(OrderProfit(),4));
                      }
                      
                   }
                   
               }  
}

void Answer_read()
{
Answer[1]="5";
filehandle_answer=FileOpen("Answer.txt",FILE_READ|FILE_COMMON|FILE_CSV);
   int i=1;
   while(!FileIsEnding(filehandle_answer)) 
      { 
          Answer[i]=FileReadString(filehandle_answer,30);
          i++;
      }
for(int j=1;j<=i-1;j++)
{
   string Market=StringSubstr(Answer[j],0,6); 
   string Position=StringSubstr(Answer[j],7,2);
   int Timeframe=StrToInteger(StringSubstr(Answer[j],10,4)); 
   double NNA_Answer=StrToDouble(StringSubstr(Answer[j],14,5)); 
      if ((Position=="BY") || (Position=="SL")) {Get_Position(Market , Position , Timeframe , NNA_Answer);}
}
      FileClose(filehandle_answer);
if(Answer[1]!="5")
{
      FileDelete("Answer.txt",FILE_COMMON|FILE_CSV);
      GlobalVariableSet("Answer_read",0);  
}      

// Print Markets 

//2   1  EURUSD 
//3   2  EURAUD 
//4   3  EURCAD 
//5   4  EURCHF 
//6   5  EURGBP 
//7   6  EURJPY
//8   7  EURNZD 
//9   8  AUDUSD 
//10  9  USDCAD 
//11  10 USDCHF
//12  11 GBPUSD
//13  12 USDJPY
//14  13 NZDUSD

My_print("EURUSD",1,80 , "1" , 10);   
My_print("EURAUD",1,110 , "2" , 10);   
My_print("EURCAD",1,140 , "3" , 10);   
My_print("EURCHF",1,170 , "4" , 10);   
My_print("EURGBP",1,200 , "5" , 10);   
My_print("EURJPY",1,230 , "6" , 10);   
My_print("EURNZD",1,260 , "7" , 10);   
My_print("AUDUSD",1,290 , "8" , 10);   
My_print("USDCAD",1,320 , "9" , 10);   
My_print("USDCHF",1,350 , "10" , 10); 
My_print("GBPUSD",1,380 , "11" , 10); 
My_print("USDJPY",1,410 , "12" , 10); 
My_print("NZDUSD",1,440 , "13" , 10); 
  
// Print Time Frames 
My_print("15",80,40 , "14" , 10);   
My_print("30",110,40 , "15" , 10);   
My_print("01",140,40 , "16" , 10); 
My_print("02",170,40 , "17" , 10); 
My_print("03",200,40 , "18" , 10); 
My_print("04",230,40 , "19" , 10); 
My_print("05",260,40 , "20" , 10); 
My_print("06",290,40 , "21" , 10); 
My_print("07",320,40 , "22" , 10); 
My_print("08",350,40 , "23" , 10); 
My_print("09",380,40 , "24" , 10); 
My_print("10",420,40 , "25" , 10); 
My_print("11",450,40 , "26" , 10); 
My_print("12",480,40 , "27" , 10); 
My_print("13",510,40 , "28" , 10); 
My_print("14",540,40 , "29" , 10); 
My_print("15",570,40 , "30" , 10); 
My_print("16",600,40 , "31" , 10); 
My_print("17",630,40 , "32" , 10); 
My_print("18",660,40 , "33" , 10); 
My_print("19",690,40 , "34" , 10); 
My_print("20",720,40 , "35" , 10); 
My_print("21",750,40 , "36" , 10); 
My_print("22",780,40 , "37" , 10); 
My_print("23",810,40 , "38" , 10); 
My_print("D1",840,40 , "39" , 10); 
// Display NNA Answer on Screen 
for(int j=1;j<=i-1;j++)
{
   string Market=StringSubstr(Answer[j],0,6); 
   int Timeframe=StrToInteger(StringSubstr(Answer[j],10,4)); 
   double NNA_Answer=StrToDouble(StringSubstr(Answer[j],14,5)); 
   
//  ---------Print EURUSD ------------------------------   
   if((Market=="EURUSD") && (Timeframe==15))
   {
   My_print(DoubleToStr(NNA_Answer,2),80,80 , "46" , 7);
   }
   if((Market=="EURUSD") && (Timeframe==30))
   {
   My_print(DoubleToStr(NNA_Answer,2),110,80 , "47" , 7);
   }
   if((Market=="EURUSD") && (Timeframe==60))
   {
   My_print(DoubleToStr(NNA_Answer,2),140,80 , "48" , 7);
   }
   if((Market=="EURUSD") && (Timeframe==120))
   {
   My_print(DoubleToStr(NNA_Answer,2),170,80 , "49" , 7);
   }
   if((Market=="EURUSD") && (Timeframe==180))
   {
   My_print(DoubleToStr(NNA_Answer,2),200,80 , "50" , 7);
   }
   if((Market=="EURUSD") && (Timeframe==240))
   {
   My_print(DoubleToStr(NNA_Answer,2),230,80 , "51" , 7);
   }
//  ---------Print EURAUD ------------------------------   
   if((Market=="EURAUD") && (Timeframe==15))
   {
   My_print(DoubleToStr(NNA_Answer,2),80,110 , "52" , 7);
   }
   if((Market=="EURAUD") && (Timeframe==30))
   {
   My_print(DoubleToStr(NNA_Answer,2),110,110 , "53" , 7);
   }
   if((Market=="EURAUD") && (Timeframe==60))
   {
   My_print(DoubleToStr(NNA_Answer,2),140,110 , "54" , 7);
   }
   if((Market=="EURAUD") && (Timeframe==120))
   {
   My_print(DoubleToStr(NNA_Answer,2),170,110 , "55" , 7);
   }
   if((Market=="EURAUD") && (Timeframe==180))
   {
   My_print(DoubleToStr(NNA_Answer,2),200,110 , "56" , 7);
   }
   if((Market=="EURAUD") && (Timeframe==240))
   {
   My_print(DoubleToStr(NNA_Answer,2),230,110 , "57" , 7);
   }
//  ---------Print EURCAD ------------------------------   
   if((Market=="EURCAD") && (Timeframe==15))
   {
   My_print(DoubleToStr(NNA_Answer,2),80,140 , "58" , 7);
   }
   if((Market=="EURCAD") && (Timeframe==30))
   {
   My_print(DoubleToStr(NNA_Answer,2),110,140 , "59" , 7);
   }
   if((Market=="EURCAD") && (Timeframe==60))
   {
   My_print(DoubleToStr(NNA_Answer,2),140,140 , "60" , 7);
   }
   if((Market=="EURCAD") && (Timeframe==120))
   {
   My_print(DoubleToStr(NNA_Answer,2),170,140 , "61" , 7);
   }
   if((Market=="EURCAD") && (Timeframe==180))
   {
   My_print(DoubleToStr(NNA_Answer,2),200,140 , "62" , 7);
   }
   if((Market=="EURCAD") && (Timeframe==240))
   {
   My_print(DoubleToStr(NNA_Answer,2),230,140 , "63" , 7);
   }   
   // ---------Print EURCHF ------------------------------   
   if((Market=="EURCHF") && (Timeframe==15))
   {
   My_print(DoubleToStr(NNA_Answer,2),80,170 , "64" , 7);
   }
   if((Market=="EURCHF") && (Timeframe==30))
   {
   My_print(DoubleToStr(NNA_Answer,2),110,170 , "65" , 7);
   }
   if((Market=="EURCHF") && (Timeframe==60))
   {
   My_print(DoubleToStr(NNA_Answer,2),140,170 , "66" , 7);
   }
   if((Market=="EURCHF") && (Timeframe==120))
   {
   My_print(DoubleToStr(NNA_Answer,2),170,170 , "67" , 7);
   }
   if((Market=="EURCHF") && (Timeframe==180))
   {
   My_print(DoubleToStr(NNA_Answer,2),200,170 , "68" , 7);
   }
   if((Market=="EURCHF") && (Timeframe==240))
   {
   My_print(DoubleToStr(NNA_Answer,2),230,170 , "69" , 7);
   }   
   // ---------Print EURGBP ------------------------------   
   if((Market=="EURGBP") && (Timeframe==15))
   {
   My_print(DoubleToStr(NNA_Answer,2),80,200 , "70" , 7);
   }
   if((Market=="EURGBP") && (Timeframe==30))
   {
   My_print(DoubleToStr(NNA_Answer,2),110,200 , "71" , 7);
   }
   if((Market=="EURGBP") && (Timeframe==60))
   {
   My_print(DoubleToStr(NNA_Answer,2),140,200 , "72" , 7);
   }
   if((Market=="EURGBP") && (Timeframe==120))
   {
   My_print(DoubleToStr(NNA_Answer,2),170,200 , "73" , 7);
   }
   if((Market=="EURGBP") && (Timeframe==180))
   {
   My_print(DoubleToStr(NNA_Answer,2),200,200 , "74" , 7);
   }
   if((Market=="EURGBP") && (Timeframe==240))
   {
   My_print(DoubleToStr(NNA_Answer,2),230,200 , "75" , 7);
   }   
   // ---------Print EURJPY ------------------------------   
   if((Market=="EURJPY") && (Timeframe==15))
   {
   My_print(DoubleToStr(NNA_Answer,2),80,230 , "76" , 7);
   }
   if((Market=="EURJPY") && (Timeframe==30))
   {
   My_print(DoubleToStr(NNA_Answer,2),110,230 , "77" , 7);
   }
   if((Market=="EURJPY") && (Timeframe==60))
   {
   My_print(DoubleToStr(NNA_Answer,2),140,230 , "78" , 7);
   }
   if((Market=="EURJPY") && (Timeframe==120))
   {
   My_print(DoubleToStr(NNA_Answer,2),170,230 , "79" , 7);
   }
   if((Market=="EURJPY") && (Timeframe==180))
   {
   My_print(DoubleToStr(NNA_Answer,2),200,230 , "80" , 7);
   }
   if((Market=="EURJPY") && (Timeframe==240))
   {
   My_print(DoubleToStr(NNA_Answer,2),230,230 , "81" , 7);
   }           
   // ---------Print EURNZD------------------------------   
   if((Market=="EURNZD") && (Timeframe==15))
   {
   My_print(DoubleToStr(NNA_Answer,2),80,260 , "82" , 7);
   }
   if((Market=="EURNZD") && (Timeframe==30))
   {
   My_print(DoubleToStr(NNA_Answer,2),110,260 , "83" , 7);
   }
   if((Market=="EURNZD") && (Timeframe==60))
   {
   My_print(DoubleToStr(NNA_Answer,2),140,260 , "84" , 7);
   }
   if((Market=="EURNZD") && (Timeframe==120))
   {
   My_print(DoubleToStr(NNA_Answer,2),170,260 , "85" , 7);
   }
   if((Market=="EURNZD") && (Timeframe==180))
   {
   My_print(DoubleToStr(NNA_Answer,2),200,260 , "86" , 7);
   }
   if((Market=="EURNZD") && (Timeframe==240))
   {
   My_print(DoubleToStr(NNA_Answer,2),230,260 , "87" , 7);
   }     
   // ---------Print AUDUSD------------------------------   
   if((Market=="AUDUSD") && (Timeframe==15))
   {
   My_print(DoubleToStr(NNA_Answer,2),80,290 , "88" , 7);
   }
   if((Market=="AUDUSD") && (Timeframe==30))
   {
   My_print(DoubleToStr(NNA_Answer,2),110,290 , "89" , 7);
   }
   if((Market=="AUDUSD") && (Timeframe==60))
   {
   My_print(DoubleToStr(NNA_Answer,2),140,290 , "90" , 7);
   }
   if((Market=="AUDUSD") && (Timeframe==120))
   {
   My_print(DoubleToStr(NNA_Answer,2),170,290 , "91" , 7);
   }
   if((Market=="AUDUSD") && (Timeframe==180))
   {
   My_print(DoubleToStr(NNA_Answer,2),200,290 , "92" , 7);
   }
   if((Market=="AUDUSD") && (Timeframe==240))
   {
   My_print(DoubleToStr(NNA_Answer,2),230,290 , "93" , 7);
   } 
   // ---------Print USDCAD------------------------------   
   if((Market=="USDCAD") && (Timeframe==15))
   {
   My_print(DoubleToStr(NNA_Answer,2),80,320 , "94" , 7);
   }
   if((Market=="USDCAD") && (Timeframe==30))
   {
   My_print(DoubleToStr(NNA_Answer,2),110,320 , "95" , 7);
   }
   if((Market=="USDCAD") && (Timeframe==60))
   {
   My_print(DoubleToStr(NNA_Answer,2),140,320 , "96" , 7);
   }
   if((Market=="USDCAD") && (Timeframe==120))
   {
   My_print(DoubleToStr(NNA_Answer,2),170,320 , "97" , 7);
   }
   if((Market=="USDCAD") && (Timeframe==180))
   {
   My_print(DoubleToStr(NNA_Answer,2),200,320 , "98" , 7);
   }
   if((Market=="USDCAD") && (Timeframe==240))
   {
   My_print(DoubleToStr(NNA_Answer,2),230,320 , "99" , 7);
   }   
   // ---------Print USDCHF------------------------------   
   if((Market=="USDCHF") && (Timeframe==15))
   {
   My_print(DoubleToStr(NNA_Answer,2),80,350 , "100" , 7);
   }
   if((Market=="USDCHF") && (Timeframe==30))
   {
   My_print(DoubleToStr(NNA_Answer,2),110,350 , "101" , 7);
   }
   if((Market=="USDCHF") && (Timeframe==60))
   {
   My_print(DoubleToStr(NNA_Answer,2),140,350 , "102" , 7);
   }
   if((Market=="USDCHF") && (Timeframe==120))
   {
   My_print(DoubleToStr(NNA_Answer,2),170,350 , "103" , 7);
   }
   if((Market=="USDCHF") && (Timeframe==180))
   {
   My_print(DoubleToStr(NNA_Answer,2),200,350 , "104" , 7);
   }
   if((Market=="USDCHF") && (Timeframe==240))
   {
   My_print(DoubleToStr(NNA_Answer,2),230,350 , "105" , 7);
   }   
   // ---------Print GBPUSD------------------------------   
   if((Market=="GBPUSD") && (Timeframe==15))
   {
   My_print(DoubleToStr(NNA_Answer,2),80,380 , "106" , 7);
   }
   if((Market=="GBPUSD") && (Timeframe==30))
   {
   My_print(DoubleToStr(NNA_Answer,2),110,380 , "107" , 7);
   }
   if((Market=="GBPUSD") && (Timeframe==60))
   {
   My_print(DoubleToStr(NNA_Answer,2),140,380 , "108" , 7);
   }
   if((Market=="GBPUSD") && (Timeframe==120))
   {
   My_print(DoubleToStr(NNA_Answer,2),170,380 , "109" , 7);
   }
   if((Market=="GBPUSD") && (Timeframe==180))
   {
   My_print(DoubleToStr(NNA_Answer,2),200,380 , "110" , 7);
   }
   if((Market=="GBPUSD") && (Timeframe==240))
   {
   My_print(DoubleToStr(NNA_Answer,2),230,380 , "111" , 7);
   }           
   // ---------Print USDJPY------------------------------   
   if((Market=="USDJPY") && (Timeframe==15))
   {
   My_print(DoubleToStr(NNA_Answer,2),80,410 , "112" , 7);
   }
   if((Market=="USDJPY") && (Timeframe==30))
   {
   My_print(DoubleToStr(NNA_Answer,2),110,410 , "113" , 7);
   }
   if((Market=="USDJPY") && (Timeframe==60))
   {
   My_print(DoubleToStr(NNA_Answer,2),140,410 , "114" , 7);
   }
   if((Market=="USDJPY") && (Timeframe==120))
   {
   My_print(DoubleToStr(NNA_Answer,2),170,410 , "115" , 7);
   }
   if((Market=="USDJPY") && (Timeframe==180))
   {
   My_print(DoubleToStr(NNA_Answer,2),200,410 , "116" , 7);
   }
   if((Market=="USDJPY") && (Timeframe==240))
   {
   My_print(DoubleToStr(NNA_Answer,2),230,410 , "117" , 7);
   }   
   // ---------Print NZDUSD------------------------------   
   if((Market=="NZDUSD") && (Timeframe==15))
   {
   My_print(DoubleToStr(NNA_Answer,2),80,440 , "118" , 7);
   }
   if((Market=="NZDUSD") && (Timeframe==30))
   {
   My_print(DoubleToStr(NNA_Answer,2),110,440 , "119" , 7);
   }
   if((Market=="NZDUSD") && (Timeframe==60))
   {
   My_print(DoubleToStr(NNA_Answer,2),140,440 , "120" , 7);
   }
   if((Market=="NZDUSD") && (Timeframe==120))
   {
   My_print(DoubleToStr(NNA_Answer,2),170,440 , "121" , 7);
   }
   if((Market=="NZDUSD") && (Timeframe==180))
   {
   My_print(DoubleToStr(NNA_Answer,2),200,440 , "122" , 7);
   }
   if((Market=="NZDUSD") && (Timeframe==240))
   {
   My_print(DoubleToStr(NNA_Answer,2),230,440 , "123" , 7);
   }         
}

}

void Get_Position(string Market , string Position , int Timeframe , double NNA_Answer)
{
if(Position=="BY")
{
   int tiket=OrderSend(Market+MarketPrefix,OP_BUY,LOTS,Ask,10,0,0,"Afsaneh",Timeframe,0,Blue);
   SendNotification("Position "+Position+" in "+Market+" at time frame "+IntegerToString(Timeframe)+" successfully opend and NNA_Answer was : "+DoubleToString(NNA_Answer));
}
if(Position=="SL")
{
   int tiket=OrderSend(Market+MarketPrefix,OP_SELL,LOTS,Bid,10,0,0,"Afsaneh",Timeframe,0,Red);
   SendNotification("Position "+Position+" in "+Market+" at time frame "+IntegerToString(Timeframe)+" successfully opend and NNA_Answer was : "+DoubleToString(NNA_Answer));
}
} 

void My_print(string Text,int x,int y , string lable , int size)
{

   string text=(Text); 
   ObjectCreate(lable,OBJ_LABEL,0,0,0);
   ObjectSet(lable,OBJPROP_XDISTANCE,x);
   ObjectSet(lable,OBJPROP_YDISTANCE,y);
   ObjectSetText(lable,text,size,"Arial",Yellow);
   WindowRedraw(); 
}