// COMANDOS PARA EXECUTAR
// cd D:\Documentos\GITHUB\Jogo_da_velha_C-
// dotnet run

using System.Runtime.CompilerServices;

// BIBLIOTECAS
using System.Data;
using System;

// CRIANDO A CLASSE
class JOGO_DA_VELHA
{
    // VARIÁVEIS DE INSTÂNCIA DA CLASSE
    private static char[,] tabuleiro = new char[3, 3];

    // METODO DA CLASSE P/ CRIAR O tabuleiro
    public static void criartabuleiro()
    {

    }

    // METODO DA CLASSE P/ CRIAR E NOMEAR JOGADORES
    public static void criarJogadores()
    {
        Console.WriteLine("Insira um nome para o Player1:");
        string player1 = Console.ReadLine() ?? string.Empty;
        Console.WriteLine("\nInsira um nome para o Player2:");
        string player2 = Console.ReadLine() ?? string.Empty;
    }
    
    // METODO P/ SORTEAR QUEM VAI COMEÇAR A JOGAR
    public static int sortearJogador()
    {
        Random random = new Random();

        // GERAR UM NÚMERO ALEATÓRIO
        int numeroAleatorio = random.Next(2);

        return numeroAleatorio;
    }
    
    // METODO P/ JOGAR
    public static void inicarJogada(int numeroAleatorio)
        {
            if (numeroAleatorio == 0)
            {
                System.Console.WriteLine("Player 1, insira o Valor da linha e o Valor da coluna na qual deseja jogar: \n(linha,coluna)\n");
                string posicao1 = Console.ReadLine() ?? string.Empty;

                // DIVIDIR A POSIÇÃO E INSERIR NO LOCAL ESPECIFICADO
                string[] posicaoNoArray = posicao1.Split(',');
                int linha = int.Parse(posicaoNoArray[0]);
                int coluna = int.Parse(posicaoNoArray[1]);
                tabuleiro[linha,coluna] = O;
            }
            else
            {
                System.Console.WriteLine("Player 2, insira o Valor da linha e o Valor da coluna na qual deseja jogar: \n(linha,coluna)\n");
                string posicao2 = Console.ReadLine() ?? string.Empty;;
                // DIVIDIR A POSIÇÃO E INSERIR NO LOCAL ESPECIFICADO
                string[] posicaoNoArray = posicao2.Split(',');
                int linha = int.Parse(posicaoNoArray[0]);
                int coluna = int.Parse(posicaoNoArray[1]);
                tabuleiro[linha,coluna] = X;
            }
    }
    /*
    // METODO P/ VERIFICAR SE TEM ESPACO LIVRE NO ARRAY
        {

        }

    // METODO P/ VERIFICAR GANHADOR
        {

        }
    */

    // METODO P/ EXECUTAR OS PROCESSOS
    static void Main()
    {
        JOGO_DA_VELHA.criartabuleiro();
        JOGO_DA_VELHA.criarJogadores();
        int numeroAleatorio = JOGO_DA_VELHA.sortearJogador();
        JOGO_DA_VELHA.inicarJogada(numeroAleatorio);
        Console.WriteLine(tabuleiro[1,1]);
    } 
}
