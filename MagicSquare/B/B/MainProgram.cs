using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace B
{
    class MainProgram
    {
        static void Main(string[] args)
        {
            Console.Write("Enter square size: ");
            int size = Convert.ToInt16(Console.ReadLine());

            // array input
            int[,] arr = new int[size,size];
            for (int i = 0; i < size; i++)
            {
                for (int j = 0; j < size; j++)
                {
                    Console.Write("a[{0},{1}]=", i, j);
                    arr[i, j] = Convert.ToInt16(Console.ReadLine());
                }
            }

            // array output
            Console.WriteLine("input:");
            for (int i = 0; i < size; i++)
            {
                for (int j = 0; j < size; j++)
                {
                    Console.Write("{0}", arr[i,j]);
                }
                Console.WriteLine();
            }

            // result "yes" or "no"
            string result = "";
            if ( IsMagic(size, arr) == true)
            {
                //result = "yes";
                result = "no";
            }
            else
            {
                //result = "no";
                result = "yes";
            }
            Console.WriteLine("output:");
            Console.WriteLine(result);

            //write "yes" or "no" to file result.txt
            System.IO.File.WriteAllText(@"result.txt", result);

            //make a console window stay for 5 sec
            System.Threading.Thread.Sleep(5000);
         } //Main
            
        //if a suare is magic
        static bool IsMagic(int size, int[,] array)
        {
            //count the first row sum
            int sum = 0;
            for (int j = 0; j < size; j++)
            {
                sum = sum + array[0, j] ;
            }

            //check if the sun is same in each row
            for (int i = 0; i < size; i++)
            {
                int tmpSum = 0;
                for (int j = 0; j < size; j++)
                {
                    tmpSum = tmpSum + array[i, j];
                }
                if (tmpSum != sum)
                    return false;
            }

            //check if the sun is same in each column
            for (int i = 0; i < size; i++)
            {
                int tmpSum = 0;
                for (int j = 0; j < size; j++)
                {
                    tmpSum = tmpSum + array[j, i];              
                }
                if (tmpSum != sum)
                    return false;
            }
            
            // it seems sums are same
            return true;
        }//IsMagic
    }
}
