%option case-insensitive

%{

/*
Analisador Léxico para busca de lexemas em rede social.
O programa irá buscar por notícias relacionadas às eleições 2014,
para os candidatos do segundo turno (Dilma 13 do PT e Aécio 45 do PSDB).
O intuito é a identificação da situação de cada candidato e os rumores
mencionados nas redes sociais, de modo à tentar estimar um futuro resultado.
Veículos utilizados: G1 e Yahoo
--
@name:	Eleições 2014 - Notícias dos Candidatos
@autor: Lennon Alves / Felipe Gusmão
@date:	16 / 10 / 2014 
*/

int buscaAecio = 0;
int saudeAecio = 0, educacaoAecio = 0, segurancaAecio = 0;


int buscaDilma = 0;
int saudeDilma = 0, educacaoDilma = 0, segurancaDilma = 0;

%}

SAUDE						sa(u|ú)de
EDUCACAO					educa(c|ç)(a|ã)o
SEGURANCA					seguran(c|ç)a


BUSCAAECIO 					a(e|é)cio
SAUDEAECIO 					({SAUDE}.*{BUSCAAECIO})|({BUSCAAECIO}.*{SAUDE})
EDUCACAOAECIO				({EDUCACAO}.*{BUSCAAECIO})|({BUSCAAECIO}.*{EDUCACAO})
SEGURANCAAECIO				({SEGURANCA}.*{BUSCAAECIO})|({BUSCAAECIO}.*{SEGURANCA})

SAUDEEDUCACAOAECIO			({SAUDEAECIO}{EDUCACAOAECIO})|({EDUCACAOAECIO}{SAUDEAECIO})
SAUDESEGURANCAAECIO			({SAUDEAECIO}{SEGURANCAAECIO})|({SEGURANCAAECIO}|{SAUDEAECIO})
EDUCACAOSEGURANCAAECIO		({EDUCACAOAECIO}{SEGURANCAAECIO})|({SEGURANCAAECIO}|{EDUCACAOAECIO})


BUSCADILMA 					dilma
SAUDEDILMA 					({SAUDE}.*{BUSCADILMA})|({BUSCADILMA}.*{SAUDE})
EDUCACAODILMA				({EDUCACAO}.*{BUSCADILMA})|({BUSCADILMA}.*{EDUCACAO})
SEGURANCADILMA				({SEGURANCA}.*{BUSCADILMA})|({BUSCADILMA}.*{SEGURANCA})

SAUDEEDUCACAODILMA			({SAUDEDILMA}{EDUCACAODILMA})|({EDUCACAODILMA}{SAUDEDILMA})
SAUDESEGURANCADILMA			({SAUDEDILMA}{SEGURANCADILMA})|({SEGURANCADILMA}{SAUDEDILMA})
EDUCACAOSEGURANCADILMA		({EDUCACAODILMA}{SEGURANCADILMA})|({SEGURANCADILMA}{EDUCACAODILMA})

%%

{BUSCAAECIO} 				{ ++buscaAecio; }

{SAUDEAECIO}				{ ++buscaAecio; ++saudeAecio; }
{EDUCACAOAECIO}				{ ++buscaAecio; ++educacaoAecio; }
{SEGURANCAAECIO}			{ ++buscaAecio; ++segurancaAecio; }

{SAUDEEDUCACAOAECIO}		{ ++buscaAecio; ++saudeAecio; ++educacaoAecio; }
{SAUDESEGURANCAAECIO}		{ ++buscaAecio; ++saudeAecio; ++segurancaAecio; }
{EDUCACAOSEGURANCAAECIO}	{ ++buscaAecio; ++educacaoAecio; ++segurancaAecio; }


{BUSCADILMA} 				{ ++buscaDilma; }

{SAUDEDILMA}				{ ++buscaDilma; ++saudeDilma; }
{EDUCACAODILMA}				{ ++buscaDilma; ++educacaoDilma; }
{SEGURANCADILMA}			{ ++buscaDilma; ++segurancaDilma; }

{SAUDEEDUCACAODILMA}		{ ++buscaDilma; ++saudeDilma; ++educacaoDilma; }
{SAUDESEGURANCADILMA}		{ ++buscaDilma; ++saudeDilma; ++segurancaDilma; }
{EDUCACAOSEGURANCADILMA}	{ ++buscaDilma; ++educacaoDilma; ++segurancaDilma; }

.							{}

%%

int main ( int nArgs, char* szArgs[] )
{
	yylex();
	printf("Foi(Foram) encontrada(s) %d marcação(ões) envolvendo o candidato Aécio Neves\n", buscaAecio);
	printf("%d marcação(ões) sobre saúde;\n%d marcação(ões) sobre educação;\n%d marcação(ões) sobre segurança.", saudeAecio, educacaoAecio, segurancaAecio);

	printf("\n\nFoi(Foram) encontrada(s) %d marcação(ões) envolvendo a candidata Dilma Rousseff\n", buscaDilma);
	printf("%d marcação(ões) sobre saúde;\n%d marcação(ões) sobre educação;\n%d marcação(ões) sobre segurança.", saudeDilma, educacaoDilma, segurancaDilma);

	printf("\n\nFim de programa.\n\n");
	return 0;
}
