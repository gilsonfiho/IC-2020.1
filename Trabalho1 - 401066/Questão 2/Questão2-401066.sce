/*Questão 2:   Dada a base de dados abaixo, na qual a primeira e segunda colunas são as variáveis
regressoras (x1 e x2) e a terceira coluna é a variável dependente (y), determine o modelo
de regressão múltipla (plano) com parâmetros estimados pelo método dos mínimos
quadrados. Avalie a qualidade do modelo pela métrica R2.*/

//Aluno: Francisco Gilson Pereira Almeida Filho
//Matrícula: 401066

//Lendo os dados do arquivo do aerogerador
A = read('Dados.txt',-1,3); //Ajustado m=-1 para que todo o arquivo seja lido.
x1 = A(:,1)
x2 = A(:,2)
y = A(:,3)
//Número de amostras
n = size(y)(1)
//Média das amostras
ym = sum(y)/n

//Concatenação da funçao de ordem 1
x_1 = cat(2,ones(x1),x1,x2);

//Coeficientes de ordem 1
B1 = (x_1'*x_1)^-1 * (x_1'*y);

//y = Xβ de ordem 1
y1 = x_1*B1;

//Medida dos coeficientes de determinação de ordem 1
R2_Ordem1 = 1-sum(y^2-y1^2)/sum(y^2-ym^2)

//Avaliando a qualidade de cada modelo pela métrica R2
disp("R2 da ordem 1: ")
//Exibição do R2 de ordem 1
disp(R2_Ordem1)


//Ploatando o plano de ordem 
plot3d(x1,x2,y1,'blue')

//Cria a matriz de 0 a 200, 20 a 20
[a,b] = meshgrid(0:20:200);

//Equação do plano
z = B1(1) + (B1(2)*a) + (B1(3)*b)

//Plota o plano
surf(a,b,z)

//Gera os pontos no grafico
scatter3(x1,x2,y)







