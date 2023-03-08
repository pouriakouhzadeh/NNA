from genericpath import getatime
from http import client
import logging
from sqlite3 import TimeFromTicks
from symtable import Symbol
import sys
from datetime import datetime
from os import environ, makedirs
from os.path import abspath, join
from time import sleep, time
import time
from tokenize import Double
from typing import Any
from aiohttp import ClientSession
from coinmetrics.api_client import CoinMetricsClient
import string, os
# test----------------
from binance.enums import *
import aiohttp
from binance.client import Client ,BinanceAPIException
from binance.enums import *
import subprocess, sys
from subprocess import Popen, PIPE
from pytz_deprecation_shim import UTC
#-----------------------------------
import urllib.parse,  urllib.request
from urllib.parse import urljoin, urlencode
import json, hashlib, hmac, time
from datetime import datetime
import requests
import ctypes


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

BASE_URL = 'https://api.binance.com'
apiKey = 'w5j5P2K56zwwmyFvAhcS4Q6ujDy5Rnw6BG2iIldW7w2h1YU0PAtaNezEM0hffDim'
secret = '8xUa6ftwnOO0uW7a9zO9XwVEI5DPommzzLr4kmka0cbdQ0PDerM1jK5Qk08DW01j'

os.system("cls")
print("\033[1;33;40m Welcome to Binanace NNA expert... \n")
# print("Welcome to Binanace NNA expert...",'\n')


# def getBalances():
PATH = '/api/v3/account'
timestamp = int(time.time() * 1000)
headers = {
    'X-MBX-APIKEY': apiKey
}
params = {
    'recvWindow': 5000,
    'timestamp': timestamp
}
query_string = urllib.parse.urlencode(params)
params['signature'] = hmac.new(secret.encode('utf-8'), query_string.encode('utf-8'), hashlib.sha256).hexdigest()
url = urljoin(BASE_URL, PATH)
print (url)
r = requests.get(url, headers=headers, params=params)
#     global dataSet
#     dataSet = r.__dict__


# getBalances()
        # element = dataSet.pop(1)
# print(dataSet.get(1,"ada"))
# print("ADA" in dataSet)
# for i in range(100) :
    # i=i+1
    # first_value = list(dataSet.values())[0][i]
    # print(first_value)

B_client=Client(apiKey,secret)


B_client.futures_account
transaction = B_client.transfer_spot_to_margin(asset='USDT', amount='600')
logger = logging.getLogger()
stream_handler = logging.StreamHandler()
level = logging.INFO
stream_handler.level = level
formatter = logging.Formatter(
    datefmt="[%Y-%m-%d %H:%M:%S]", fmt="%(asctime)-15s %(levelname)s %(message)s"
)

while 0<1 : 

                
    # 1 : Reading NNA answer file 
    market="EMPTY"
    opration="EMPTY"
    prive="EMPTY"
    if(os.access("Answer.txt",os.R_OK)):
        f = open("Answer.txt", "r")
        market=(f.readline())
        opration=(f.readline())
        NNA_answer=(f.readline())
        price=(f.readline())
        f.close()
    # 3 : Execut instraction and send Order's to exchange
    if(opration=="None\n" and market=="ETH\n"):
        print("NNA expert not answer at curret time ...\n")
    if(opration=="BUY\n" and market=="ETH\n"):
            print("\033[1;32;40m NNA expert try to get BUY position ...\n")
            # print("NNA expert try to get BUY position ...\n")
            r=dict(B_client.get_asset_balance('usdt'))
            temp=float(r['free'])
            if(temp>10):
                print("your corrent asset in USDT is : "+r['free'])           
                print("Getting position...")
                btc_price = B_client.get_symbol_ticker(symbol="ETHUSDT")
                p=dict(btc_price)
                pri=p['price']
                print(pri)
                q=temp/float(pri)
                q=q*1000
                q=round(q)
                q=q/1000
                print(q)
                try:
                    buy_limit = B_client.create_order(
                    symbol='ETHUSDT',
                    side='BUY',
                    type='LIMIT',
                    timeInForce='GTC',
                    quantity=q,
                    price=pri)
                    print("Order is open successfully...")
                except BinanceAPIException as e:
                # error handling goes here
                    print(e)

                # buy_order = B_client.create_order(symbol='ETHUSDT', side='BUY', type='MARKET', quantity=1)
                # B_client.order_limit_buy(timeInForce='GTC',symbol='eth',quantity=temp ,price=)
            if(temp<10):
                    print("Asset not enough or you are in position ....")
                    ethasset=B_client.get_asset_balance('ETH')
                    ethasset1=dict(ethasset)
                    print("Your ETH aseet is : ",ethasset1['free'])
                    # if(float(ethasset1['free'])>0.001 ):
                        # print(B_client.get_open_orders('ETHUSDT'))
    
    if(market!="EMPTY"):
        if (os.access("Answer.txt",os.W_OK)) :
            os.remove("Answer.txt");

    # get balances for all assets & some account information

    # print('order',client.get_open_orders)
    # print(client.get_asset_balance(asset='ETH'))


        time.sleep(10)
