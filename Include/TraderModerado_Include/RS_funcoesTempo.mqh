//+------------------------------------------------------------------+
//|                                              ES_funcoesTempo.mqh |
//|                                  Copyright 2020, Trader Moderado |
//|                                    www.tradermoderado.weebly.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, Trader Moderado."
#property link      "www.tradermoderado.weebly.com"

//--- CONCATENAR HORÁRIO (FUNÇÃO)
string   ConcatenarHorario(int  horaFuncao, int minutoFuncao)
  {
   int minutoArredondado = (minutoFuncao / Period()) * Period();

   string horarioConcatenado = "";

   if(minutoArredondado < 10)
     {
      horarioConcatenado = IntegerToString(horaFuncao) + ":" + IntegerToString(minutoArredondado) + "0";
     }
   else
     {
      horarioConcatenado = IntegerToString(horaFuncao) + ":" + IntegerToString(minutoArredondado);
     }

   return(horarioConcatenado);
  }

//--- DEFINIR HORÁRIO (FUNÇÃO)
datetime DefinirHorario(int  diaSemana_funcao)
  {
   datetime horarioDefinido = NULL;

   if(diaSemana_funcao == 6)
     {
      horarioDefinido = TimeCurrent() - 86400;
     }
   else
      if(diaSemana_funcao == 0)
        {
         horarioDefinido = TimeCurrent() - 172800;
        }
      else
        {
         horarioDefinido = TimeCurrent();
        }

   return  horarioDefinido;
  }

//--- FORMATAR HORÁRIO
datetime FormatarHorario(int  anoFuncao, int  mesFuncao, int   diaFuncao, string horarioSelecionado_concatenadoFuncao, int diaAnterior_funcao)
  {
   string   horarioAglutinado = IntegerToString(anoFuncao) + "." + IntegerToString(mesFuncao) + "." + IntegerToString(diaFuncao) + " " + horarioSelecionado_concatenadoFuncao;

   datetime horarioFormatado = StringToTime(horarioAglutinado);

   horarioFormatado = horarioFormatado - (diaAnterior_funcao * 86400);

   return   horarioFormatado;
  }

//--- AJUSTAR HORÁRIO (PROCEDIMENTO)
void AjustarHorario(int  diaSemana_funcao, datetime  &horarioVerificado_funcao)
  {
   if(diaSemana_funcao == 6)
     {
      horarioVerificado_funcao = horarioVerificado_funcao - 86400;
     }
   else
      if(diaSemana_funcao == 0)
        {
         horarioVerificado_funcao = horarioVerificado_funcao - 172800;
        }
      else
        {
         horarioVerificado_funcao = TimeCurrent();
        }
  }

//--- DEFINE O DECRESCIMO DO FINAL DOS MINUTOS PARA QUADRANTES
int   DefinirDecrescimo_Minutos(int   velasPor_quadranteFuncao)
  {
   int   decrescimoMinutos_funcao = 1;

   if(velasPor_quadranteFuncao == 5)
     {
      decrescimoMinutos_funcao = 1;
     }
   else
      if(velasPor_quadranteFuncao == 6)
        {
         decrescimoMinutos_funcao = 5;
        }
      else
         if(velasPor_quadranteFuncao == 4)
           {
            decrescimoMinutos_funcao = 15;
           }

   return   decrescimoMinutos_funcao;
  }

//--- VERIFICAR HORÁRIO DE NEGOCIAÇÃO (FUNÇÃO)
bool  VerificarHorario_Negociacao(int   horaAtual_funcao, int   horaInicio_operacoesFuncao, int horaFim_operacoesFuncao, int  minutoAtual_funcao, int minutoInicio_operacoesFuncao, int minutoFim_operacoesFuncao, MqlDateTime   &horarioLocal, int decrescimoMinutos_funcao)
  {
   bool           horarioVerificado = false;

   if(horaAtual_funcao == horaInicio_operacoesFuncao -1 &&
      minutoAtual_funcao >= minutoInicio_operacoesFuncao + 60 - decrescimoMinutos_funcao)
     {
      horarioVerificado = false;
      Comment("Falta Pouco Para a (Possível) Primeira Negociação! Servidor (" + StringFormat("%02i", horaAtual_funcao) + ":" + StringFormat("%02i", minutoAtual_funcao) + ")" +
              "  Local: (" + StringFormat("%02i", horarioLocal.hour) + ":" + StringFormat("%02i", horarioLocal.min) + ")");
     }
   else
      if(horaAtual_funcao == horaInicio_operacoesFuncao &&
         minutoAtual_funcao >= minutoInicio_operacoesFuncao)
        {
         horarioVerificado = true;
         Comment("Dentro Do Horário de Negociação. Servidor (" + StringFormat("%02i", horaAtual_funcao) + ":" + StringFormat("%02i", minutoAtual_funcao) + ")" +
                 "  Local: (" + StringFormat("%02i", horarioLocal.hour) + ":" + StringFormat("%02i", horarioLocal.min) + ")");
        }
      else
         if(horaAtual_funcao > horaInicio_operacoesFuncao &&
            horaAtual_funcao < horaFim_operacoesFuncao)
           {
            horarioVerificado = true;
            Comment("Dentro Do Horário de Negociação. Servidor (" + StringFormat("%02i", horaAtual_funcao) + ":" + StringFormat("%02i", minutoAtual_funcao) + ")" +
                    "  Local: (" + StringFormat("%02i", horarioLocal.hour) + ":" + StringFormat("%02i", horarioLocal.min) + ")");
           }
         else
            if(horaAtual_funcao == horaFim_operacoesFuncao && minutoAtual_funcao < minutoFim_operacoesFuncao)
              {
               horarioVerificado = true;
               Comment("Dentro Do Horário de Negociação. Servidor (" + StringFormat("%02i", horaAtual_funcao) + ":" + StringFormat("%02i", minutoAtual_funcao) + ")" +
                       "  Local: (" + StringFormat("%02i", horarioLocal.hour) + ":" + StringFormat("%02i", horarioLocal.min) + ")");
              }
            else
              {
               horarioVerificado = false;
               Comment("Fora do Horário de Negociação. Servidor (" + StringFormat("%02i", horaAtual_funcao) + ":" + StringFormat("%02i", minutoAtual_funcao) + ")" +
                       "  Local: (" + StringFormat("%02i", horarioLocal.hour) + ":" + StringFormat("%02i", horarioLocal.min) + ")");
              }

   return horarioVerificado;
  }

//--- FILTRA AS VELAS E INFORMAÇÕES DE ACORDO COM AS ESCOLHAS DO USUÁRIO E ELIMINA ANOMALIAS
void  FiltrarCopia_TempoAnomalias(datetime   dataInicial_funcao, datetime   dataFinal_funcao, MqlRates   &dadosVelas_funcao[])
  {
   MqlDateTime    verificadorSemana_antecessor;
   MqlDateTime    verificadorSemana_sucessor;
   bool           diferenca1 = false;
   bool           trocaSemana = false;
   int            diferencaSegundos1_funcao = 0;
   int            divisorPeriodo_funcao = 60;
   int            diferencaVelas1_funcao = 0;
   int            diferencaVelas2_funcao = 0;
   int            acrescimoMinutos_funcao = 1;
   int            minutoFinalizacao_semana = 59;
   int            minutoInicializacao_semana = 00;

//--- Estabelece o divisor dos segundos de acordo com o timeframe
   if(Period() == PERIOD_M1)
     {
      divisorPeriodo_funcao = 60;
      acrescimoMinutos_funcao = 1;
      minutoFinalizacao_semana = 59;
     }
   else
      if(Period() == PERIOD_M5)
        {
         divisorPeriodo_funcao = 300;
         acrescimoMinutos_funcao = 5;
         minutoFinalizacao_semana = 55;
        }
      else
         if(Period() == PERIOD_M15)
           {
            divisorPeriodo_funcao = 900;
            acrescimoMinutos_funcao = 15;
            minutoFinalizacao_semana = 45;
           }

//--- Copia os dados das velas de acordo com o que é disponibilizado no servidor e isola o horário das mesmas
   ZeroMemory(dadosVelas_funcao);

   CopyRates(Symbol(), Period(), dataInicial_funcao, dataFinal_funcao, dadosVelas_funcao);

//--- Confirma se o primeiro horário copiado é diferente do proposto e calcula a diferença em segundos
   if(dadosVelas_funcao[0].time > dataInicial_funcao)
     {
      diferencaSegundos1_funcao = (int) dadosVelas_funcao[0].time - (int) dataInicial_funcao;
      diferenca1 = true;
     }
   else
      if(dadosVelas_funcao[0].time < dataInicial_funcao)
        {
         diferencaSegundos1_funcao = (int) dataInicial_funcao - (int) dadosVelas_funcao[0].time;
         diferenca1 = true;
        }
      else
        {
         diferencaSegundos1_funcao = 0;
         diferenca1 = false;
        }

   if(diferenca1 == true)
     {
      //--- Cálculo da diferença em número de velas:
      diferencaVelas1_funcao = diferencaSegundos1_funcao / divisorPeriodo_funcao;

      //--- Aumenta o tamanho do vetor de acordo com o número de elementos faltantes
      ArrayResize(dadosVelas_funcao, (ArrayRange(dadosVelas_funcao, 0) + diferencaVelas1_funcao), 0);

      //--- Move os elementos do vetor para a direita (liberando os espaços iniciais)
      for(int i = ArrayRange(dadosVelas_funcao, 0) - 1; i - diferencaVelas1_funcao >= 0; i--)
        {
         dadosVelas_funcao[i] = dadosVelas_funcao[i - diferencaVelas1_funcao];
        }

      //--- Substitui os primeiros elementos por valores falsos
      for(int i = diferencaVelas1_funcao - 1; i >= 0; i--)
        {
         dadosVelas_funcao[i].time = dadosVelas_funcao[i + 1].time - divisorPeriodo_funcao;
         dadosVelas_funcao[i].open = 0;
         dadosVelas_funcao[i].high = 0;
         dadosVelas_funcao[i].low = 0;
         dadosVelas_funcao[i].close = 0;
         dadosVelas_funcao[i].real_volume = 0;
         dadosVelas_funcao[i].spread = 0;
         dadosVelas_funcao[i].tick_volume = 0;
        }
     }

//--- Substitui anomalias subsequentes por valores falsos
   for(int i = 2; i < ArrayRange(dadosVelas_funcao, 0); i++)
     {
      TimeToStruct(dadosVelas_funcao[i - 1].time, verificadorSemana_antecessor);
      TimeToStruct(dadosVelas_funcao[i].time, verificadorSemana_sucessor);

      if(verificadorSemana_antecessor.day_of_week == 5 && verificadorSemana_sucessor.day_of_week == 1)
        {
         trocaSemana = true;
        }
      else
        {
         trocaSemana = false;
        }

      if(trocaSemana == false && dadosVelas_funcao[i].time != dadosVelas_funcao[i - 1].time + divisorPeriodo_funcao)
        {
         ArrayResize(dadosVelas_funcao, ArrayRange(dadosVelas_funcao, 0) + 1, 0);

         //--- Move os elementos do vetor para a direita
         for(int j = ArrayRange(dadosVelas_funcao, 0) - 1; j - 1 >= i; j--)
           {
            dadosVelas_funcao[j] = dadosVelas_funcao[j - 1];
           }

         //--- Preenche os espaços com valores falsos
         dadosVelas_funcao[i].time = dadosVelas_funcao[i - 1].time + divisorPeriodo_funcao;
         dadosVelas_funcao[i].open = 0;
         dadosVelas_funcao[i].high = 0;
         dadosVelas_funcao[i].low = 0;
         dadosVelas_funcao[i].close = 0;
         dadosVelas_funcao[i].real_volume = 0;
         dadosVelas_funcao[i].spread = 0;
         dadosVelas_funcao[i].tick_volume = 0;
        }
      else
         if(trocaSemana == true && verificadorSemana_antecessor.min != minutoFinalizacao_semana)
           {
            ArrayResize(dadosVelas_funcao, ArrayRange(dadosVelas_funcao, 0) + 1, 0);

            //--- Move os elementos do vetor para a direita
            for(int j = ArrayRange(dadosVelas_funcao, 0) - 1; j - 1 >= i; j--)
              {
               dadosVelas_funcao[j] = dadosVelas_funcao[j - 1];
              }

            //--- Preenche os espaços com valores falsos
            dadosVelas_funcao[i].time = dadosVelas_funcao[i - 1].time + divisorPeriodo_funcao;
            dadosVelas_funcao[i].open = 0;
            dadosVelas_funcao[i].high = 0;
            dadosVelas_funcao[i].low = 0;
            dadosVelas_funcao[i].close = 0;
            dadosVelas_funcao[i].real_volume = 0;
            dadosVelas_funcao[i].spread = 0;
            dadosVelas_funcao[i].tick_volume = 0;
           }
         else
            if(trocaSemana == true && verificadorSemana_sucessor.min != minutoInicializacao_semana)
              {
               diferencaVelas2_funcao = verificadorSemana_sucessor.min;

               for(int j = 0; j < diferencaVelas2_funcao; j++)
                 {
                  //--- Move os elementos do vetor para a direita
                  ArrayResize(dadosVelas_funcao, ArrayRange(dadosVelas_funcao, 0) + 1, 0);

                  for(int k = ArrayRange(dadosVelas_funcao, 0) - 1; k - 1 >= i; k--)
                    {
                     dadosVelas_funcao[k] = dadosVelas_funcao[k - 1];
                    }

                  //--- Preenche os espaços com valores falsos
                  dadosVelas_funcao[i].time = dadosVelas_funcao[i].time - divisorPeriodo_funcao;
                  dadosVelas_funcao[i].open = 0;
                  dadosVelas_funcao[i].high = 0;
                  dadosVelas_funcao[i].low = 0;
                  dadosVelas_funcao[i].close = 0;
                  dadosVelas_funcao[i].real_volume = 0;
                  dadosVelas_funcao[i].spread = 0;
                  dadosVelas_funcao[i].tick_volume = 0;
                 }
               diferencaVelas2_funcao = 0;
              }
     }
  }

//--- FILTRA A JANELA DE HORÁRIO DE ACORDO COM AS PREFERÊNCIAS DO USUÁRIO
void  FiltrarCopia_TempoUsuario(MqlRates &copiaTempo_vetorOriginal[], int diaSemana_inicio, int   diaSemana_fim,
                                int   horaInicio_funcao, int horaFim_funcao, int   minutoInicio_funcao,  int   minutoFim_funcao, int   decrescimoMinutos_funcao)
  {
   datetime       dataFake = D'1984.04.01 00:00';
   int            numeroLinhas_vetorOriginal = 0;
   int            contadorExcesso_valoresVetor = 0;
   MqlDateTime    diaVerificado_estrutura;
   MqlRates       copiaTempo_vetorAlterado[];
   bool           valorDuplicado = false;
   int            indice = 0;
   MqlRates       copiaTempo_vetorDuplicado[];
   MqlRates       copiaTempo_vetorDuplicado2[];
   int            numeroLinhas_vetorFinal = 0;

   minutoFim_funcao = minutoFim_funcao - decrescimoMinutos_funcao;

   if(minutoFim_funcao < 0)
     {
      minutoFim_funcao += 60;
      horaFim_funcao -= 1;
     }

   ZeroMemory(copiaTempo_vetorAlterado);
   ArrayResize(copiaTempo_vetorAlterado, ArrayRange(copiaTempo_vetorOriginal, 0), 0);
   ZeroMemory(copiaTempo_vetorAlterado);

   numeroLinhas_vetorOriginal = ArrayRange(copiaTempo_vetorAlterado, 0);

//--- Elimina o que não entra no critério
   for(int i = 0; i < numeroLinhas_vetorOriginal; i++)
     {
      TimeToStruct(copiaTempo_vetorOriginal[i].time, diaVerificado_estrutura);

      if((diaVerificado_estrutura.day_of_week >= diaSemana_inicio && diaVerificado_estrutura.day_of_week <= diaSemana_fim) &&
         ((diaVerificado_estrutura.hour == horaInicio_funcao && diaVerificado_estrutura.min >= minutoInicio_funcao) ||
          (diaVerificado_estrutura.hour == horaFim_funcao && diaVerificado_estrutura.min <= minutoFim_funcao) ||
          (diaVerificado_estrutura.hour > horaInicio_funcao && diaVerificado_estrutura.hour < horaFim_funcao)))
        {
         copiaTempo_vetorAlterado[i] = copiaTempo_vetorOriginal[i];
        }
      else
        {
         //--- Conta quantos elementos não entraram no critério
         contadorExcesso_valoresVetor = contadorExcesso_valoresVetor + 1;
        }
     }

//--- Substitui valores nulos por valor inútil repetido
   for(int i = 0; i < numeroLinhas_vetorOriginal; i++)
     {
      if(copiaTempo_vetorAlterado[i].time == NULL)
        {
         copiaTempo_vetorAlterado[i].time = dataFake;
        }
     }

   ArrayResize(copiaTempo_vetorDuplicado, numeroLinhas_vetorOriginal);

//--- Elimina duplicados
   for(int i = 0; i < numeroLinhas_vetorOriginal; i++)
     {
      for(int j = 0; j < indice; j++)
        {
         if(copiaTempo_vetorAlterado[i].time == copiaTempo_vetorDuplicado[j].time)
           {
            valorDuplicado = true;
            break;
           }
        }
      if(!valorDuplicado)
        {
         copiaTempo_vetorDuplicado[indice] = copiaTempo_vetorAlterado[i];
         indice++;
        }
      valorDuplicado = false; // restart
     }

//--- Substitui data fake pelo próximo valor (duplicando o dito cujo)
   for(int i = 0; i < numeroLinhas_vetorOriginal - 1; i++)
     {
      if(copiaTempo_vetorDuplicado[i].time == dataFake && i < numeroLinhas_vetorOriginal)
        {
         copiaTempo_vetorDuplicado[i] = copiaTempo_vetorDuplicado[i + 1];
        }
     }

   ArrayResize(copiaTempo_vetorDuplicado2, numeroLinhas_vetorOriginal, 0);

//--- Elimina duplicados novamente
   indice = 0;
   for(int i = 0; i < numeroLinhas_vetorOriginal; i++)   // looping through the main array
     {
      for(int j = 0; j < indice; j++)   // looping through the target array where we know we have data. if we haven't found anything yet, this wont loop
        {
         if(copiaTempo_vetorDuplicado[i].time == copiaTempo_vetorDuplicado2[j].time)   // if the target array contains the object, no need to continue further.
           {
            valorDuplicado = true;
            break; // break from this loop
           }
        }
      if(!valorDuplicado)   // if our value wasn't found in 'b' we will add this non-dublicate at index
        {
         copiaTempo_vetorDuplicado2[indice] = copiaTempo_vetorDuplicado[i];
         indice++;
        }
      valorDuplicado = false; // restart
     }

   numeroLinhas_vetorFinal = numeroLinhas_vetorOriginal - contadorExcesso_valoresVetor;

   ArrayResize(copiaTempo_vetorDuplicado2, numeroLinhas_vetorFinal, 0);
   ArrayResize(copiaTempo_vetorOriginal, numeroLinhas_vetorFinal, 0);
   ZeroMemory(copiaTempo_vetorOriginal);
   ArrayCopy(copiaTempo_vetorOriginal, copiaTempo_vetorDuplicado2, 0, 0, WHOLE_ARRAY);
  }

//--- CHECAR FORMAÇÃO DE VELAS NO QUADRANTE ATUAL(M1 - FUNÇÃO)
int  ChecarHorario_QuadranteAtual_M1(int  minutoLocal_funcao)
  {
   int   velaAtual_funcao = 0;

   if(minutoLocal_funcao == 00 || minutoLocal_funcao == 05
      || minutoLocal_funcao == 10 || minutoLocal_funcao == 15
      || minutoLocal_funcao == 20 || minutoLocal_funcao == 25
      || minutoLocal_funcao == 30 || minutoLocal_funcao == 35
      || minutoLocal_funcao == 40 || minutoLocal_funcao == 45
      || minutoLocal_funcao == 50 || minutoLocal_funcao == 55)
     {
      velaAtual_funcao = 0;
     }
   else
      if(minutoLocal_funcao == 01 || minutoLocal_funcao == 06
         || minutoLocal_funcao == 11 || minutoLocal_funcao == 16
         || minutoLocal_funcao == 21 || minutoLocal_funcao == 26
         || minutoLocal_funcao == 31 || minutoLocal_funcao == 36
         || minutoLocal_funcao == 41 || minutoLocal_funcao == 46
         || minutoLocal_funcao == 51 || minutoLocal_funcao == 56)
        {
         velaAtual_funcao = 1;
        }
      else
         if(minutoLocal_funcao == 02 || minutoLocal_funcao == 07
            || minutoLocal_funcao == 12 || minutoLocal_funcao == 17
            || minutoLocal_funcao == 22 || minutoLocal_funcao == 27
            || minutoLocal_funcao == 32 || minutoLocal_funcao == 37
            || minutoLocal_funcao == 42 || minutoLocal_funcao == 47
            || minutoLocal_funcao == 52 || minutoLocal_funcao == 57)
           {
            velaAtual_funcao = 2;
           }
         else
            if(minutoLocal_funcao == 03 || minutoLocal_funcao == 08
               || minutoLocal_funcao == 13 || minutoLocal_funcao == 18
               || minutoLocal_funcao == 23 || minutoLocal_funcao == 28
               || minutoLocal_funcao == 33 || minutoLocal_funcao == 38
               || minutoLocal_funcao == 43 || minutoLocal_funcao == 48
               || minutoLocal_funcao == 53 || minutoLocal_funcao == 58)
              {
               velaAtual_funcao = 3;
              }
            else
               if(minutoLocal_funcao == 04 || minutoLocal_funcao == 09
                  || minutoLocal_funcao == 14 || minutoLocal_funcao == 19
                  || minutoLocal_funcao == 24 || minutoLocal_funcao == 29
                  || minutoLocal_funcao == 34 || minutoLocal_funcao == 39
                  || minutoLocal_funcao == 44 || minutoLocal_funcao == 49
                  || minutoLocal_funcao == 54 || minutoLocal_funcao == 59)
                 {
                  velaAtual_funcao = 4;
                 }
               else
                 {
                  velaAtual_funcao = 0;
                 }

   return velaAtual_funcao;
  }

//--- CHECAR FORMAÇÃO DE VELAS NO QUADRANTE ATUAL(M5 - FUNÇÃO)
int  ChecarHorario_QuadranteAtual_M5(int  minutoLocal_funcao)
  {
   int   velaAtual_funcao = 0;

   if((minutoLocal_funcao >= 00 && minutoLocal_funcao <= 04)
      || (minutoLocal_funcao >= 30 && minutoLocal_funcao <= 34))
     {
      velaAtual_funcao = 0;
     }
   else
      if((minutoLocal_funcao >= 05 && minutoLocal_funcao <= 09)
         || (minutoLocal_funcao >= 35 && minutoLocal_funcao <= 39))
        {
         velaAtual_funcao = 1;
        }
      else
         if((minutoLocal_funcao >= 10 && minutoLocal_funcao <= 14)
            || (minutoLocal_funcao >= 40 && minutoLocal_funcao <= 44))
           {
            velaAtual_funcao = 2;
           }
         else
            if((minutoLocal_funcao >= 15 && minutoLocal_funcao <= 19)
               || (minutoLocal_funcao >= 45 && minutoLocal_funcao <= 49))
              {
               velaAtual_funcao = 3;
              }
            else
               if((minutoLocal_funcao >= 20 && minutoLocal_funcao <= 24)
                  || (minutoLocal_funcao >= 50 && minutoLocal_funcao <= 54))
                 {
                  velaAtual_funcao = 4;
                 }
               else
                  if((minutoLocal_funcao >= 25 && minutoLocal_funcao <= 29)
                     || (minutoLocal_funcao >= 55 && minutoLocal_funcao <= 59))
                    {
                     velaAtual_funcao = 5;
                    }
                  else
                    {
                     velaAtual_funcao = 0;
                    }

   return velaAtual_funcao;
  }

//--- CHECAR FORMAÇÃO DE VELAS NO QUADRANTE ATUAL(M15 - FUNÇÃO)
int  ChecarHorario_QuadranteAtual_M15(int  minutoLocal_funcao)
  {
   int   velaAtual_funcao = 0;

   if(minutoLocal_funcao >= 00 && minutoLocal_funcao <= 14)
     {
      velaAtual_funcao = 0;
     }
   else
      if(minutoLocal_funcao >= 15 && minutoLocal_funcao <= 29)
        {
         velaAtual_funcao = 1;
        }
      else
         if(minutoLocal_funcao >= 30 && minutoLocal_funcao <= 44)
           {
            velaAtual_funcao = 2;
           }
         else
            if(minutoLocal_funcao >= 45 && minutoLocal_funcao <= 59)
              {
               velaAtual_funcao = 3;
              }
            else
              {
               velaAtual_funcao = 0;
              }

   return velaAtual_funcao;
  }

//--- DEFINIR ACRÉSCIMO DE MINUTOS PARA QUADRANTE COMPLEMENTAR (FUNÇÃO)
int   DefinirAcrescimo_SegundosComplementares(int   velasPor_quadranteFuncao)
  {
   int   acrescimoSegundos_complementares = 0;

   if(velasPor_quadranteFuncao == 5)
     {
      acrescimoSegundos_complementares = 60;
     }
   else
      if(velasPor_quadranteFuncao == 6)
        {
         acrescimoSegundos_complementares = 300;
        }
      else
         if(velasPor_quadranteFuncao == 4)
           {
            acrescimoSegundos_complementares = 900;
           }

   return   acrescimoSegundos_complementares;
  }

//---

//+------------------------------------------------------------------+
