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

namespace WindowsFormsApp1
{
    public partial class Form1 : Form
    {
        private FilterInfoCollection CaptureDevice;
        private VideoCaptureDevice FinalFrame;

        SpeechSynthesizer ss;
        List<string> qrs;

        public Form1()
        {
            InitializeComponent();
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            CaptureDevice = new FilterInfoCollection(FilterCategory.VideoInputDevice);
            foreach (FilterInfo Device in CaptureDevice)
            {
                comboBox1.Items.Add(Device.Name);
            }

            comboBox1.SelectedIndex = 0;
            FinalFrame = new VideoCaptureDevice();

            ss = new SpeechSynthesizer();
            ss.Rate = -5;
            ss.Volume = 90;

            qrs = new List<string>();

        }

        private void button1_Click(object sender, EventArgs e)
        {
            FinalFrame = new VideoCaptureDevice(CaptureDevice[comboBox1.SelectedIndex].MonikerString);
            FinalFrame.NewFrame += new NewFrameEventHandler(FinalFrame_NewFrame);
            FinalFrame.Start();

            timer1.Enabled = true;
            timer1.Start();

        }

        private void button2_Click(object sender, EventArgs e)
        {
            timer1.Enabled = true;
            timer1.Start();
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
                   
                    if (!(qrs is null) &&  qrs.Where(m => m == decoded).Count()==0)
                    { 
                    
                    listBox1.Items.Insert(0, DateTime.Now.ToLongTimeString() + " " + decoded);
                    ss.SpeakAsync("Have a nice day, internal " + decoded);
                    timer1.Stop();
                    System.Threading.Thread.Sleep(10000);
                    timer1.Start();
                    }
                
                        qrs.Add(decoded);
                }
                else
                {
                    qrs.Clear();
                }
            }
            catch (Exception ex)
            {
                qrs.Clear();
            }
        }

        private void btnGetToken_Click(object sender, EventArgs e)
        {

      
        }

        private void txtValor_TextChanged(object sender, EventArgs e)
        {
            QrEncoder qrEncoder = new QrEncoder(ErrorCorrectionLevel.H);
            QrCode qrCode = new QrCode();
            qrEncoder.TryEncode(txtValor.Text, out qrCode);

            GraphicsRenderer renderer = new GraphicsRenderer(new FixedCodeSize(400, QuietZoneModules.Zero), Brushes.Black, Brushes.White);
            MemoryStream ms = new MemoryStream();

            renderer.WriteToStream(qrCode.Matrix, ImageFormat.Png, ms);
            var imageTemporal = new Bitmap(ms);
            var imagen = new Bitmap(imageTemporal, new Size(new System.Drawing.Point(100, 100)));
            panelResultado.BackgroundImage = imagen;
        }

    }
}
