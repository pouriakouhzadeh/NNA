import pandas as pd
from pycoingecko import CoinGeckoAPI

cg = CoinGeckoAPI()







nested_lists = cg.get_coin_history_by_id(id="bitcoin", date='2021-06-03')
