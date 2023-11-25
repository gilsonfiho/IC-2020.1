//Avaliação Final de Inteligência computacional

//Aluno = Francisco Gilson Pereira Almeida Filho
//Matricula = 401066

/* Crie um algoritmo genético para o problema do caixeiro viajante representado por
um grafo completo não direcionado de 14 vértices (cidades).
O algoritmo deve exibir o melhor caminho encontrado e o seu custo de percurso. Use
crossover de mapeamento parcial e mutação por permutação de elementos.
*/

//Matriz com as distancias entre as cidades

//A matriz foi espelhada na parte inferior para facilitar a leitura
Distancia =   [ 0 1 2 4 6 2 2 3 3 5 6 1 4 5;
                1 0 3 2 1 3 6 3 4 4 2 4 4 4;
                2 3 0 1 3 3 2 3 4 1 3 5 5 6;
                4 2 1 0 5 1 4 2 3 4 4 8 2 2;
                6 1 3 5 0 2 1 6 5 2 3 4 2 2;
                2 3 3 1 2 0 3 1 2 3 5 7 3 4;
                2 6 2 4 1 3 0 2 1 2 5 2 4 3;
                3 3 3 2 6 1 2 0 5 5 1 5 3 6;
                3 4 4 3 5 2 1 5 0 1 4 4 5 3;
                5 4 1 4 2 3 2 5 1 0 5 4 4 2;
                6 2 3 4 3 5 5 1 4 5 0 4 2 1;
                1 4 5 8 4 7 2 5 4 4 4 0 1 3;
                4 4 5 2 2 3 4 3 5 4 2 1 0 1;
                5 4 6 2 2 4 3 6 3 2 1 3 1 0;];
                
        
//Função de avaliação, somatorio das distancias entre as cidades
function [Nota]=Aval(Ind)
    Nota = 0
    for j=1:13
        Nota = Nota + Distancia(Ind(j),Ind(j+1))
    end 
    //Distancia entre a ultima cidade e a primeira
    Nota = Nota + Distancia(Ind(14),Ind(1))
endfunction


//Função do Crossover de mapeamento parcial 
function [Filho1,Filho2]=Cross(Pai1,Pai2)
   
    //Inicialmente os filhos sao clones dos pais
    Filho1 = Pai1
    Filho2 = Pai2
    
    //Selecao dos pontos de corte 
    P1 = ceil(rand()*13)//Ponto de corte [1,13]
    P2 = ceil(rand()*13)//Ponto de corte [1,13]
    
    //Garante que P1 < P2
    if P1 > P2 then
        aux = P2 
        P2 = P1
        P1 = aux        
    end
    P2 = P2 + 1

    //Permuta entre os pontos de corte
    for i=P1:P2
        Filho1(i) = Pai2(i)
        Filho2(i) = Pai1(i)
    end

    //Garante que não haja repetição de cidades nos filhos, atraves do mapeamento de genes do ponto de corte
    //Filho1
    for i = 1:14
        j=P1
        while(j<=P2)
            if Filho1(i) == Filho1(j) & ((i<P1)|(i>P2))   then
            Filho1(i) = Filho2(j)
            j=P1-1 
            end
        j=j+1
        end
    end
    
    //Filho2
    for i = 1:14
        j=P1 
        while(j<=P2)
            if Filho2(i) == Filho2(j) & ((i<P1)|(i>P2))   then
            Filho2(i) = Filho1(j)
            j=P1-1 
            end
        j=j+1
        end
    end
endfunction

//Mutacao por permutação de elementos
function [Ind_M]= Mutacao(ind)
    Ind_M = ind
   
    if rand()*100 <= 0.5  then //Da uma chance de 0.5% para que ocorra a mutacao
    
    //Seleciona os elementos da permutacao
    P1 = ceil(rand()*14)
    P2 = ceil(rand()*14)
        
    //Permuta os elementos selecionados
    aux = Ind_M(P1)
    Ind_M(P1) = Ind_M(P2)
    Ind_M(P2) = aux             
    end
endfunction

//Selecao dos pais utilizando o torneio
function [Pais]= Selecao(Populacao)
    NP = 0.2*Tam // Numero de participantes do torneio
    Pais = Populacao;
    Participantes = Populacao(1:NP,1:14);
    Notas_T = Notas(1:NP)    
    for i=1:Tam        
        for j=1:NP//Seleciona os participantes aleatoriamente
            Participantes(j,1:14) = Populacao(ceil(rand()*Tam),1:14)
        end
        
        for j=1:NP
            Notas_T(j) = Aval(Participantes(j,1:14))
        end
            
        [val pos] = min(Notas_T) 
        Pais(i,1:14)=Participantes(pos,1:14); 
    end
endfunction

//Geração da primeira populacao
//Vetores que serão utilizados para armazenar a populacao, Pais e Filhos em cada geracao
Populacao=[]
Pais=[]
Filhos=[]

Tam = 100;//Tamanho da população
Notas=zeros(1,Tam)

//Sorteio sem repetição das cidades
for i=1:Tam//Gerando com Tam individuos
    C = []; //Vetor auxiliar vazio
    sel = 14; //Indice com o valor da quantidade de cidades
    cidades = [1 2 3 4 5 6 7 8 9 10 11 12 13 14]
        while(sel>0)//Seleciona uma das 14 cidades e em seguida a elimina do vetor cidades
        R = ceil(rand()*sel);//Seleciona um numero entre 1 e sel(inicialmente 14 e é decremantado a cada iteracao)
        C = [C cidades(R)]//Adiciona a cidade no vetor auxiliar C
        cidades(R)=[]//Remove a cidade selecionada do vetor cidade
        sel=sel-1;//Decrementa o valor de sel
        end
    Populacao = [Populacao; C]//Adiciona o vetor C em Populacao
end

NG=100//Numero de gerações

for n=1:NG
    //Avalicacao dos individuos
    for i=1:Tam
        Notas(i) = Aval(Populacao(i,1:14));
    end
   
    //Selecao dos pais
    Pais = Selecao(Populacao)
    
    //Cruzamento
    for i=1:2:Tam
        [Filhos(i,1:14) Filhos(i+1,1:14)] = Cross(Pais(i,1:14),Pais(i+1,1:14)) ;
    end
    
    //Mutacao
    for i=1:Tam
        Filhos(i,1:14) = Mutacao(Filhos(i,1:14));
    end
        
    Populacao = Filhos        
end

[val pos]=min(Notas)
    
disp("Melhor caminho:")

disp(Populacao(pos,1:14))

disp("Custo do melhor caminho:")

disp(val)
