using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.IO;
using AForge;
using AForge.Video;
using AForge.Video.DirectShow;
using ZXing;
using ZXing.Aztec;
using System.Speech;
using System.Speech.Synthesis;
using Gma.QrCodeNet.Encoding;
using Gma.QrCodeNet.Encoding.Windows.Render;
using System.Drawing.Imaging;
using System.Net.Http;
using Newtonsoft.Json;
using System.Net;
using System.Net.Http.Headers;
using System.Threading;

namespace WindowsFormsApp1
{
    public partial class frmInspecciones : Form
    {
        private FilterInfoCollection CaptureDevice;
        private VideoCaptureDevice FinalFrame;

        
        string UltimaLectura="";
        static string baseUrl = Properties.Settings.Default.api;
        static string accessToken = null;

        public frmInspecciones()
        {
            Thread t = new Thread(new ThreadStart(StartForm));
            t.Start();
            Thread.Sleep(5000);
        

            InitializeComponent();
            t.Abort();
        }
        public void StartForm()
        {
            Application.Run(new frmSplash());
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            CaptureDevice = new FilterInfoCollection(FilterCategory.VideoInputDevice);
            foreach (FilterInfo Device in CaptureDevice)
            {
                cboCamaras.Items.Add(Device.Name);
            }

            cboCamaras.SelectedIndex = 0;
            FinalFrame = new VideoCaptureDevice();
            
            UltimaLectura="";

        }     

   
        private void Form1_FormClosing(object sender, FormClosingEventArgs e)
        {
            if (FinalFrame.IsRunning == true)
            {
                FinalFrame.Stop();
            }
        }

        private void FinalFrame_NewFrame(object sender, NewFrameEventArgs eventArgs)
        {
            try

            {
                pictureBox1.Image = (Bitmap)eventArgs.Frame.Clone();
            }
            catch (Exception ex)
            {

            }
        }

        private void timer1_Tick(object sender, EventArgs e)
        {

                try

                {
                    BarcodeReader Reader = new BarcodeReader();
                Result result = Reader.Decode((Bitmap)pictureBox1.Image);
                string decoded = result.ToString().Trim();
                if (decoded != "")
                {
                   
                    if (!UltimaLectura.Equals(decoded))
                    {
                        Firmar(decoded);//API
                        dgvInspecciones.Rows.Insert(0, new string[] { decoded, DateTime.Now.ToLongTimeString() });

                        Voz(decoded);
                        UltimaLectura = decoded ;
                    }   
                }               
            }
            catch (Exception ex)
            {                
            }
        }

    
        private void frmInspecciones_DoubleClick(object sender, EventArgs e)
        {
            UltimaLectura = "";
        }
        
        private void btnIniciarInspecciones_Click(object sender, EventArgs e)
        {
            FinalFrame = new VideoCaptureDevice(CaptureDevice[cboCamaras.SelectedIndex].MonikerString);
            FinalFrame.NewFrame += new NewFrameEventHandler(FinalFrame_NewFrame);
            FinalFrame.Start();

            timer1.Enabled = true;
            timer1.Start();
        }

        #region Api

        private static async Task<int> Firmar(string interno)
        {
            if( accessToken == null || accessToken=="") { accessToken = await GetAccessToken(); }
            await InspectorFirmar(interno);
            return 0;
        }

        private static async Task<string> GetAccessToken()
        {
            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri(baseUrl);

                // We want the response to be JSON.
                client.DefaultRequestHeaders.Accept.Clear();
                client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/x-www-form-urlencoded"));

                // Build up the data to POST.
                List<KeyValuePair<string, string>> postData = new List<KeyValuePair<string, string>>();

                postData.Add(new KeyValuePair<string, string>("grant_type", "password"));
                postData.Add(new KeyValuePair<string, string>("UserName", Properties.Settings.Default.usuario));
                postData.Add(new KeyValuePair<string, string>("Password", Properties.Settings.Default.password));
                postData.Add(new KeyValuePair<string, string>("client_id", Properties.Settings.Default.clientId));

                FormUrlEncodedContent content = new FormUrlEncodedContent(postData);

                // Post to the Server and parse the response.
                HttpResponseMessage response = await client.PostAsync("Token", content);
                string jsonString = await response.Content.ReadAsStringAsync();
                object responseData = JsonConvert.DeserializeObject(jsonString);

                // return the Access Token.
                return ((dynamic)responseData).access_token;
            }

        }
       
        
        public static async Task<bool> InspectorFirmar(string Interno)
        {


            string par = "{ \"Inspector\": \"1\",";
            par += "\"Interno\": \"" + Interno + "\",";
            par += "\"Seccion\": \"" + Properties.Settings.Default.seccionId + "\"}";
            
            HttpClient client = new HttpClient();
            System.Net.ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls12 | SecurityProtocolType.Tls11 | SecurityProtocolType.Tls;
            client.DefaultRequestHeaders.Accept.Clear();
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", accessToken);
            HttpResponseMessage response = await client.PostAsync(baseUrl + "/api/Inspector/", new StringContent(par, Encoding.UTF8, "application/json"));
            if (response.IsSuccessStatusCode)
            {
                return true;
            }
            else
            {
                MessageBox.Show("Transaccion Fallida : " + response.ToString());
                return false;
            }

        }
        #endregion

        
        private void Voz(string interno)
        {

            var synth = new SpeechSynthesizer();
            var builder = new PromptBuilder();
            synth.Rate = -2;
            synth.Volume = 100;

            builder.StartVoice("Microsoft Sabina Desktop");


            builder.AppendText("Que tenga un buen día interno " + interno);
            builder.EndVoice();
            synth.SpeakAsync(new Prompt(builder));
        }
    }
}
