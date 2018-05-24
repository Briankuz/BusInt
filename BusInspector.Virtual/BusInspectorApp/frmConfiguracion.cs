using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace WindowsFormsApp1
{
    public partial class frmConfiguracion : Form
    {
        public frmConfiguracion()
        {
            InitializeComponent();
        }

        private void Form2_Load(object sender, EventArgs e)
        {
            txtApi.Text = Properties.Settings.Default.api;
            txtClientId.Text = Properties.Settings.Default.clientId;
            txtUsuario.Text = Properties.Settings.Default.usuario;
            txtPassword.Text = Properties.Settings.Default.password;
              txtUsuarioId.Text= Properties.Settings.Default.usuarioId;
            txtSeccionId.Text=Properties.Settings.Default.seccionId ;
        }
        
        private void btnguardar_Click(object sender, EventArgs e)
        {
             Properties.Settings.Default.api= txtApi.Text;
             Properties.Settings.Default.clientId= txtClientId.Text;
             Properties.Settings.Default.usuario= txtUsuario.Text;
             Properties.Settings.Default.password= txtPassword.Text;
            Properties.Settings.Default.usuarioId = txtUsuarioId.Text;
            Properties.Settings.Default.seccionId = txtSeccionId.Text;
            Properties.Settings.Default.Save();
        }

        
  
    }
}
