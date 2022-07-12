#include <stdio.h>
#include <stdlib.h>

////////////// exame �poca normal 09/02/2021 /////////////////

//////////////   Pergunta 3  //////////////////////////////////

//nome: Dinis Meireles de Sousa Falc�o

//n�mero: 2020130403

// Estrat�gia de resolu��o:

// Dados de Entrada: int i (para o ciclo); int alteraLetra (para contagem da Letra que se vai alterar);

// Conhecimento Requerido: Sting fa n�o deve ter mais do que 10 palavras;

// Resultados Pretendidos: Mudan�a da �ltima letra de cada palavra numa frase com menos de 11 palavras;

// Estrat�gia:
// Inicializar alteraLetra a 0;
// Fazer um ciclo que corra todas as letras e, quando estiver em cima da �ltima letra de cada palavra, substituir pelo n�mero de ordem da mesma palavra;
// A �ltima letra ser� antes de cada espa�o, logo se fa[i]==' ', fa[i-1] � a �ltima letra;
// strlen(fa) para ver o cumprimento da string;
// Quando n�o houverem mais palavras, devolve '!'.


char ultimaLetra(char fa[]){

    int i;
    int alteraLetra = 0;

    for(i = 0; strlen(fa); i++){

        if (i == 0)
            continue;

        if (fa[i] == ' ')
            fa[i - 1] = alteraLetra;
            alteraLetra++;

    }
    return '!';
}

