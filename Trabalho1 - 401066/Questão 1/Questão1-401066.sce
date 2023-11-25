/*Questão 1:  Usando o conjunto de dados do aerogerador - variável de entrada (primeira coluna):
velocidade do vento; variável de saída (segunda coluna): potência gerada - determine os
modelos de regressão polinomial (graus: 1 até 5) com parâmetros estimados pelo
método dos mínimos quadrados.*/

//Aluno: Francisco Gilson Pereira Almeida Filho
//Matrícula: 401066

//Lendo os dados do arquivo do aerogerador
A = read('aerogerador.dat',-1,2); //Ajustado m=-1 para que todo o arquivo seja lido.
x = A(:,1)
y = A(:,2)
//Número de amostras
n = size(y)(1)
//Média das amostras
ym = sum(y)/n

//Concatenação da funçao de ordem 1
x1 = cat(2,ones(x),x);
//Concatenação da funçao de ordem 2
x2 = cat(2,ones(x),x,x^2);
//Concatenação da funçao de ordem 3
x3 = cat(2,ones(x),x,x^2,x^3);
//Concatenação da funçao de ordem 4
x4 = cat(2,ones(x),x,x^2,x^3,x^4);
//Concatenação da funçao de ordem 5
x5 = cat(2,ones(x),x,x^2,x^3,x^4,x^5);


//Coeficientes de ordem 1
B1 = (x1'*x1)^-1 * (x1'*y);
//Coeficientes de ordem 2
B2 = (x2'*x2)^-1 * (x2'*y);
//Coeficientes de ordem 3
B3 = (x3'*x3)^-1 * (x3'*y);
//Coeficientes de ordem 4
B4 = (x4'*x4)^-1 * (x4'*y);
//Coeficientes de ordem 5
B5 = (x5'*x5)^-1 * (x5'*y);

//y = Xβ de ordem 1
y1 = x1*B1;
//y = Xβ de ordem 2
y2 = x2*B2;
//y = Xβ de ordem 3
y3 = x3*B3;
//y = Xβ de ordem 4
y4 = x4*B4;
//y = Xβ de ordem 5
y5 = x5*B5;

//Medida dos coeficientes de determinação de ordem 1
R2_Ordem1 = 1-sum(y^2-y1^2)/sum(y^2-ym^2)
//Medida dos coeficientes de determinação de ordem 2
R2_Ordem2 = 1-sum(y^2-y2^2)/sum(y^2-ym^2)
//Medida dos coeficientes de determinação de ordem 3
R2_Ordem3 = 1-sum(y^2-y3^2)/sum(y^2-ym^2)
//Medida dos coeficientes de determinação de ordem 4
R2_Ordem4 = 1-sum(y^2-y4^2)/sum(y^2-ym^2)
//Medida dos coeficientes de determinação de ordem 5
R2_Ordem5 = 1-sum(y^2-y5^2)/sum(y^2-ym^2)

//Medida do coeficientes de determinação ajustado de ordem 1
R2aj_Ordem1 = 1-(sum(y^2-y1^2)/(n-3))/(sum(y^2-ym^2)/(n-1))
//Medida do coeficientes de determinação ajustado de ordem 2
R2aj_Ordem2 = 1-(sum(y^2-y2^2)/(n-3))/(sum(y^2-ym^2)/(n-1))
//Medida do coeficientes de determinação ajustado de ordem 3
R2aj_Ordem3 = 1-(sum(y^2-y3^2)/(n-4))/(sum(y^2-ym^2)/(n-1))
//Medida do coeficientes de determinação ajustado de ordem 4
R2aj_Ordem4 = 1-(sum(y^2-y4^2)/(n-5))/(sum(y^2-ym^2)/(n-1))
//Medida do coeficientes de determinação ajustado de ordem 5
R2aj_Ordem5 = 1-(sum(y^2-y5^2)/(n-6))/(sum(y^2-ym^2)/(n-1))

//Avaliando a qualidade de cada modelo pela métrica R2
disp("R2 da ordem 1: ")
//Exibição do R2 de ordem 1
disp(R2_Ordem1)
disp("R2 da ordem 2: ")
//Exibição do R2 de ordem 2
disp(R2_Ordem2)
disp("R2 da ordem 3: ")
//Exibição do R2 de ordem 3
disp(R2_Ordem3)
disp("R2 da ordem 4: ")
//Exibição do R2 de ordem 4
disp(R2_Ordem4)
disp("R2 da ordem 5: ")
//Exibição do R2 de ordem 5
disp(R2_Ordem5)


//Avaliando a qualidade de cada modelo pela métrica R2aj
disp("R2 ajustado da ordem 1: ")
//Exibição do R2aj de ordem 1
disp(R2aj_Ordem1)
disp("R2 ajustado da ordem 2: ")
//Exibição do R2aj de ordem 2
disp(R2aj_Ordem2)
disp("R2 ajustado da ordem 3: ")
//Exibição do R2aj de ordem 3
disp(R2aj_Ordem3)
disp("R2 ajustado da ordem 4: ")
//Exibição do R2aj de ordem 4
disp(R2aj_Ordem4)
disp("R2 ajustado da ordem 5: ")
//Exibição do R2aj de ordem 5
disp(R2aj_Ordem5)


//Dados em azul marcado por quadrados
plot(x,y,'square')
sleep(2000)
//Ploatando a curva de ordem 1 azul
plot(x,y1,'b')
sleep(2000)
//Ploatando a curva de ordem 2 em preto
plot(x,y2,'k')
sleep(2000)
//Plotando a curva de ordem 3 em amarelo 
plot(x,y3,'y')
sleep(2000)
//Plotando a curva de ordem 4 em verde 
plot(x,y4,'g')
sleep(2000)
//Plotando a curva de ordem 5 em vermelho
plot(x,y5,'r')
sleep(2000)







