from symtable import Symbol
from binance.client import Client ,BinanceAPIException
import pandas as pd
import os
import time
from datetime import timedelta, datetime
import ctypes
# ---Binance join -----------------------------------
BASE_URL = 'https://api.binance.com'
apiKey = 'w5j5P2K56zwwmyFvAhcS4Q6ujDy5Rnw6BG2iIldW7w2h1YU0PAtaNezEM0hffDim'
secret = '8xUa6ftwnOO0uW7a9zO9XwVEI5DPommzzLr4kmka0cbdQ0PDerM1jK5Qk08DW01j'
B_client=Client(apiKey,secret)

# p=B_client.futures_position_information(side='long')
# print(p)
#-----  for advance printing ------------
class COORD(ctypes.Structure):
    _fields_ = [("X", ctypes.c_short), ("Y", ctypes.c_short)] 
    def __init__(self,x,y):
        self.X = x
        self.Y = y

def gotoxy(x,y):
    INIT_POS=COORD(y,x)
    STD_OUTPUT_HANDLE= -11
    hOut = ctypes.windll.kernel32.GetStdHandle(STD_OUTPUT_HANDLE)
    ctypes.windll.kernel32.SetConsoleCursorPosition(hOut,INIT_POS)
#----------------------------------------


def if_open(symbol):
    p=B_client.futures_position_information()
    temp=pd.DataFrame(p)
    temp1=temp.loc[temp['symbol']==symbol]
    # print(temp1)
    ETH_Posi=(temp1.iloc[0,1])
    ETH_Posi=float(ETH_Posi)
    if(ETH_Posi!=0):
        return("open")
    if(ETH_Posi==0):
        return("close")

def find_qty(symbol):
    p=B_client.futures_position_information()
    temp=pd.DataFrame(p)
    temp1=temp.loc[temp['symbol']==symbol]
    ETH_Posi=(temp1.iloc[0,1])
    ETH_Posi=float(ETH_Posi)
    return(abs(ETH_Posi))

def order_send(symbol1,side1,LOT):
            eth_price = B_client.get_symbol_ticker(symbol=symbol1)
            usdt_balance=B_client.futures_account_balance(asset="USDT")
            eth_p=dict(eth_price)
            eth_price=(eth_p['price'])
            temp=pd.DataFrame(usdt_balance)
            temp1=temp.loc[temp['asset']=='USDT']
            usdt_balance=(temp1.iloc[0,3])
            # print(float(usdt_balance))
            # print(eth_price)
            quant=((float(usdt_balance)/5)/float(eth_price))
            B_client.futures_change_leverage(symbol=symbol1, leverage=LOT)
            if(symbol1=="BTCUSDT" or symbol1=="ETHUSDT"):
                quant=round(quant*1000)/1000
            if(symbol1=="BNBUSDT"):
                quant=round(quant*100)/100
            print(quant)
            try:
                B_client.futures_create_order(
                    symbol=symbol1,
                    type='MARKET',
                    side=side1,
                    quantity=quant
                    )
            except BinanceAPIException as e:
            # error handling goes here
                print("Order send error : ",e)            
            
            
def close_order(symbol1):
    if(if_open(symbol1)=="open"):           
        try:
            Close_BUY=B_client.futures_create_order(symbol=symbol1, 
                                              side='BUY', 
                                              type='MARKET', 
                                              quantity=find_qty(symbol1), 
                                              reduceOnly='true')
        except BinanceAPIException as e:
        # error handling goes here
            print("Side of opened order was BUY Try to close again .... ")
        try:
            Close_SELL=B_client.futures_create_order(symbol=symbol1, 
                                              side='SELL', 
                                              type='MARKET', 
                                              quantity=find_qty(symbol1), 
                                              reduceOnly='true')
        except BinanceAPIException as e:
        # error handling goes here
            print("Side of opened order was SELL and expert deleted it")   
                
                
                
           
# print(find_qty('ETHUSDT'))
# if_open('ETHUSDT')
# ---------Main loop
i=0
while 0<1 : 
    try :
        now = datetime.now()
        if(now.second==0 and now.minute==0):
            close_order('ETHUSDT')
            close_order('BTCUSDT')
    
        market_BTC="EMPTY"
        opration_BTC="EMPTY"
        market_ETH="EMPTY"
        opration_ETH="EMPTY"
        market_BNB="EMPTY"
        opration_BNB="EMPTY"
    
        if(os.access("Answer.txt",os.R_OK)):
            os.system("cls")
            print("\033[1;33;40m Welcome to Binanace NNA expert... \n")    
            i=0; 
            f = open("Answer.txt", "r")
            market_ETH=(f.readline())
            opration_ETH=(f.readline())
            NNA_answer_ETH=(f.readline())
            price_ETH=(f.readline())
            market_BTC=(f.readline())
            opration_BTC=(f.readline())
            NNA_answer_BTC=(f.readline())
            price_BTC=(f.readline())
            market_BNB=(f.readline())
            opration_BNB=(f.readline())
            NNA_answer_BNB=(f.readline())
            price_BNB=(f.readline())
        
            f.close()
        # get ETH position     
        if(opration_ETH=="None\n" and market_ETH=="ETH\n"):
            print("NNA expert not answer for ETH at curret time ...\n")
            if(if_open('ETHUSDT')=="open"):
                print("preparing to close ETH position ....")
                close_order('ETHUSDT')
        if(opration_BTC=="None\n" and market_BTC=="BTC\n"):
            print("NNA expert not answer for BTC at curret time ...\n")
            if(if_open('BTCUSDT')=="open"):
                print("preparing to close BTC position ....")
                close_order('BTCUSDT')
        if(opration_BNB=="None\n" and market_BNB=="BNB\n"):
            print("NNA expert not answer for BNB at curret time ...\n")
            if(if_open('BNBUSDT')=="open"):
                print("preparing to close BNB position ....")
                close_order('BNBUSDT')

        #---- Get BUY position------ 
        if(opration_ETH=="BUY\n" and market_ETH=="ETH\n"):
            if(if_open('ETHUSDT')=="close"):        
                order_send("ETHUSDT","BUY",10)
        
        #-------Get SELL position --------- 
        if(opration_ETH=="SELL\n" and market_ETH=="ETH\n"):
            if(if_open('ETHUSDT')=="close"):
                order_send("ETHUSDT","SELL",10)
        # Get BTC position 

        #---- Get BUY position------ 
        if(opration_BTC=="BUY\n" and market_BTC=="BTC\n"):
            if(if_open('BTCUSDT')=="close"):        
                order_send("BTCUSDT","BUY",10)        
        #-------Get SELL position --------- 
        if(opration_BTC=="SELL\n" and market_BTC=="BTC\n"):
            if(if_open('BTCUSDT')=="close"):
                order_send("BTCUSDT","SELL",10)
            
        #---- Get BUY position------ 
        if(opration_BNB=="BUY\n" and market_BNB=="BNB\n"):
            if(if_open('BNBUSDT')=="close"):        
                order_send("BNBUSDT","BUY",10)        
        #-------Get SELL position --------- 
        if(opration_BNB=="SELL\n" and market_BNB=="BNB\n"):
            if(if_open('BNBUSDT')=="close"):
                order_send("BNBUSDT","SELL",10)
 
        if(market_BTC!="EMPTY" and market_ETH!="EMPTY" and market_BNB!="EMPTY"):
            if (os.access("Answer.txt",os.W_OK)) :
                os.remove("Answer.txt");
                print("NNA answer ETH = ",NNA_answer_ETH)
                print("Opration ETH = ",opration_ETH)
                print("Last Close ETH = ",price_ETH)
                print("NNA answer BTC = ",NNA_answer_BTC)
                print("Opration BTC = ",opration_BTC)
                print("Last Close BTC = ",price_BTC)
                print("NNA answer BNB = ",NNA_answer_BNB)
                print("Opration BNB = ",opration_BNB)
                print("Last Close BNB = ",price_BNB,'\n\n')

                usdt_balance=B_client.futures_account_balance(asset="USDT")
                temp=pd.DataFrame(usdt_balance)
                temp1=temp.loc[temp['asset']=='USDT']
                usdt_balance=(temp1.iloc[0,3])
                print("Accunt USDT Balance = ",usdt_balance,'\n')
                print("Waiting for NNA answer.....")
            
        time.sleep(1)

        gotoxy(35,i)
        i=i+1    
        print("\033[1;32;40m▒")
        
        
        
    except:
        print('Internet disconected or VPN is off ....')            