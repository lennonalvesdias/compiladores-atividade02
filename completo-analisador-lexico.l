%{

/* Analisador Léxico para busca de lexemas em rede social.

O programa irá buscar por notícias relacionadas às eleições 2014,
para os candidatos do segundo turno (Dilma 13 do PT e Aécio 45 do PSDB).

O intuito é a identificação da situação de cada candidato e os rumores
mencionados nas redes sociais, de modo à tentar estimar um futuro resultado. */

int buscaAecio = 0;
int saudeAecio = 0, educacaoAecio = 0, segurancaAecio = 0;


int buscaDilma = 0;
int saudeDilma = 0, educacaoDilma = 0, segurancaDilma = 0;

%}

LETRAS						[a-z|A-Z]
ESPACO						" "

SAUDE						Saúde|Saude|saúde|saude
EDUCACAO					Educação|Educaçao|Educacão|Educacao|educação|educaçao|educacão|educacao
SEGURANCA					Segurança|Seguranca|segurança|seguranca


BUSCAAECIO 					Aécio|Aecio|aécio|aecio
SAUDEAECIO 					({SAUDE}({ESPACO}|{LETRAS})*{BUSCAAECIO})|({BUSCAAECIO}({ESPACO}|{LETRAS})*{SAUDE})
EDUCACAOAECIO				({EDUCACAO}({ESPACO}|{LETRAS})*{BUSCAAECIO})|({BUSCAAECIO}({ESPACO}|{LETRAS})*{EDUCACAO})
SEGURANCAAECIO				({SEGURANCA}({ESPACO}|{LETRAS})*{BUSCAAECIO})|({BUSCAAECIO}({ESPACO}|{LETRAS})*{SEGURANCA})

SAUDEEDUCACAOAECIO			({SAUDEAECIO}{EDUCACAOAECIO})|({EDUCACAOAECIO}{SAUDEAECIO})
SAUDESEGURANCAAECIO			({SAUDEAECIO}{SEGURANCAAECIO})|({SEGURANCAAECIO}|{SAUDEAECIO})
EDUCACAOSEGURANCAAECIO		({EDUCACAOAECIO}{SEGURANCAAECIO})|({SEGURANCAAECIO}|{EDUCACAOAECIO})

TODOSAECIO					({SAUDEEDUCACAOAECIO}{SEGURANCAAECIO})|({SEGURANCAAECIO}{SAUDEEDUCACAOAECIO})


BUSCADILMA 					Dilma|dilma
SAUDEDILMA 					({SAUDE}({ESPACO}|{LETRAS})*{BUSCADILMA})|({BUSCADILMA}({ESPACO}|{LETRAS})*{SAUDE})
EDUCACAODILMA				({EDUCACAO}({ESPACO}|{LETRAS})*{BUSCADILMA})|({BUSCADILMA}({ESPACO}|{LETRAS})*{EDUCACAO})
SEGURANCADILMA				({SEGURANCA}({ESPACO}|{LETRAS})*{BUSCADILMA})|({BUSCADILMA}({ESPACO}|{LETRAS})*{SEGURANCA})

SAUDEEDUCACAODILMA			({SAUDEDILMA}{EDUCACAODILMA})|({EDUCACAODILMA}{SAUDEDILMA})
SAUDESEGURANCADILMA			({SAUDEDILMA}{SEGURANCADILMA})|({SEGURANCADILMA}{SAUDEDILMA})
EDUCACAOSEGURANCADILMA		({EDUCACAODILMA}{SEGURANCADILMA})|({SEGURANCADILMA}{EDUCACAODILMA})

TODOSDILMA					({SAUDEEDUCACAODILMA}{SEGURANCADILMA})|({SEGURANCADILMA}{SAUDEEDUCACAODILMA})

%%

{BUSCAAECIO} 				{ ++buscaAecio; }

{SAUDEAECIO}				{ ++buscaAecio; ++saudeAecio; }
{EDUCACAOAECIO}				{ ++buscaAecio; ++educacaoAecio; }
{SEGURANCAAECIO}			{ ++buscaAecio; ++segurancaAecio; }

{SAUDEEDUCACAOAECIO}		{ ++buscaAecio; ++saudeAecio; ++educacaoAecio; }
{SAUDESEGURANCAAECIO}		{ ++buscaAecio; ++saudeAecio; ++segurancaAecio; }
{EDUCACAOSEGURANCAAECIO}	{ ++buscaAecio; ++educacaoAecio; ++segurancaAecio; }

{TODOSAECIO}				{ ++buscaAecio; ++saudeAecio; ++educacaoAecio; ++segurancaAecio; }


{BUSCADILMA} 				{ ++buscaDilma; }

{SAUDEDILMA}				{ ++buscaDilma; ++saudeDilma; }
{EDUCACAODILMA}				{ ++buscaDilma; ++educacaoDilma; }
{SEGURANCADILMA}			{ ++buscaDilma; ++segurancaDilma; }

{SAUDEEDUCACAODILMA}		{ ++buscaDilma; ++saudeDilma; ++educacaoDilma; }
{SAUDESEGURANCADILMA}		{ ++buscaDilma; ++saudeDilma; ++segurancaDilma; }
{EDUCACAOSEGURANCADILMA}	{ ++buscaDilma; ++educacaoDilma; ++segurancaDilma; }

{TODOSDILMA}				{ ++buscaDilma; ++saudeDilma; ++educacaoDilma; ++segurancaDilma; }

.							{}

%%

int main ( int nArgs, char* szArgs[] )
{
	yylex();
	printf("\n\nForam encontradas %d noticias do candidato Aecio\n", buscaAecio);
	printf("%d noticia(s) sobre saude, %d noticia(s) sobre educacao, %d noticia(s) sobre seguranca", saudeAecio, educacaoAecio, segurancaAecio);

	printf("\n\nForam encontradas %d noticias da candidata Dilma\n", buscaDilma);
	printf("%d noticia(s) sobre saude, %d noticia(s) sobre educacao, %d noticia(s) sobre seguranca", saudeDilma, educacaoDilma, segurancaDilma);

	printf("\nFim de programa\n\n");
	return 0;
}