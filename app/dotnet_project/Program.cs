using System;
using System.IO;
using System.Net;

namespace HelloWorld
{
    class Program
    {
        static void Main(string[] args)
        {
            HttpListener listener = new HttpListener();
            listener.Prefixes.Add("http://*:80/");
            listener.Start();
            Console.WriteLine("Listening...");
            for (;;)
            {
                HttpListenerContext ctx = listener.GetContext();
                HttpListenerResponse resp = ctx.Response;
                string msg = "Hola Mundo .NET";
                byte[] buf = System.Text.Encoding.UTF8.GetBytes(msg);
                resp.ContentLength64 = buf.Length;
                Stream st = resp.OutputStream;
                st.Write(buf, 0, buf.Length);
                st.Close();
            }
        }
    }
}
