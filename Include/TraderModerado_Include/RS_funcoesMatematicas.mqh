//+------------------------------------------------------------------+
//|                                         ES_funcoesMatriciais.mqh |
//|                                  Copyright 2020, Trader Moderado |
//|                                    www.tradermoderado.weebly.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, Trader Moderado."
#property link      "www.tradermoderado.weebly.com"

//--- VERIFICAR PORCENTAGEM DAS VELAS
double   VerificarPorcentagem_TresElementos(double contagemVerificada_funcao, double   comparacaoUm_funcao, double   comparacaoDois_funcao)
  {
   double   porcentagemEstabelecida;

   if(contagemVerificada_funcao + comparacaoUm_funcao + comparacaoDois_funcao == 0)
     {
      porcentagemEstabelecida = 0;
     }
   else
     {
      porcentagemEstabelecida = NormalizeDouble((contagemVerificada_funcao / (contagemVerificada_funcao + comparacaoUm_funcao + comparacaoDois_funcao)) * 100, 2);
     }

   return porcentagemEstabelecida;
  }

//--- IGUALA 12 VARIÁVEIS INTEIRAS A 0
void  Zerar12Variaveis(int &primeira, int   &segunda, int  &terceira, int  &quarta, int  &quinta, int  &sexta, int  &setima, int  &oitava, int  &nona, int  &decima, int  &decimaPrimeira, int  &decimaSegunda)
  {
   primeira = 0;
   segunda = 0;
   terceira = 0;
   quarta = 0;
   quinta = 0;
   sexta = 0;
   setima = 0;
   oitava = 0;
   nona = 0;
   decima = 0;
   decimaPrimeira = 0;
   decimaSegunda = 0;
  }
  
double ArredondarMultiplo_Double(double numeroArredondar_funcao, int multiploFuncao)
  {
   double   numeroArredondado = floor(numeroArredondar_funcao/multiploFuncao)*multiploFuncao;
  
   return   numeroArredondado;
  }
//+------------------------------------------------------------------+
