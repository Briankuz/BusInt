using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace WindowsFormsApp1
{
    public partial class frmSplash : Form
    {
        public frmSplash()
        {
            InitializeComponent();
            this.TransparencyKey = (BackColor);
        }

        private void frmSplash_Load(object sender, EventArgs e)
        {

        }
    }
}
