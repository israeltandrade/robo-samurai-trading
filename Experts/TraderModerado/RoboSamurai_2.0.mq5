//+------------------------------------------------------------------+
//|                                              RoboSamurai_2.0.mq5 |
//|                                  Copyright 2021, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, Trader Moderado."
#property link      "www.tradermoderado.weebly.com"
#property version   "2.00"

//+------------------------------------------------------------------+
//| IMAGENS                                                          |
//+------------------------------------------------------------------+
#resource "\\Images\\logoTitulo_fundoAmarelo.bmp"
#resource "\\Images\\logoSamurai_fundoAmarelo.bmp"
#resource "\\Images\\logoTM_fundoAmarelo.bmp"
#resource "\\Images\\meditando_fundoPreto.bmp"
#resource "\\Images\\katana_fundoPreto.bmp"
#resource "\\Images\\velaVerde.bmp"
#resource "\\Images\\velaVermelha.bmp"
#resource "\\Images\\velaCinza.bmp"
#resource "\\Images\\quadranteM1.bmp"
#resource "\\Images\\quadranteM5.bmp"
#resource "\\Images\\quadranteM15.bmp"
#resource "\\Images\\maioriaVerde.bmp"
#resource "\\Images\\maioriaVermelha.bmp"
#resource "\\Images\\maioriaSem.bmp"
#resource "\\Images\\setaPara_baixo.bmp"
#resource "\\Images\\setaPara_cima.bmp"
#resource "\\Images\\botaoInicio.bmp"
#resource "\\Images\\botaoFim.bmp"

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//--- create timer
   EventSetTimer(60);
   
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//--- destroy timer
   EventKillTimer();
   
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
//---
   
  }
//+------------------------------------------------------------------+
//| Timer function                                                   |
//+------------------------------------------------------------------+
void OnTimer()
  {
//---
   
  }
//+------------------------------------------------------------------+
//| Tester function                                                  |
//+------------------------------------------------------------------+
double OnTester()
  {
//---
   double ret=0.0;
//---

//---
   return(ret);
  }
//+------------------------------------------------------------------+
//| ChartEvent function                                              |
//+------------------------------------------------------------------+
void OnChartEvent(const int id,
                  const long &lparam,
                  const double &dparam,
                  const string &sparam)
  {
//---
   
  }
//+------------------------------------------------------------------+
