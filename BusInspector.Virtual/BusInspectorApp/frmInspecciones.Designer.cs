namespace WindowsFormsApp1
{
    partial class frmInspecciones
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.components = new System.ComponentModel.Container();
            this.label1 = new System.Windows.Forms.Label();
            this.cboCamaras = new System.Windows.Forms.ComboBox();
            this.pictureBox1 = new System.Windows.Forms.PictureBox();
            this.timer1 = new System.Windows.Forms.Timer(this.components);
            this.txtValor = new System.Windows.Forms.TextBox();
            this.panelResultado = new System.Windows.Forms.Panel();
            this.btnIniciarInspecciones = new System.Windows.Forms.Button();
            this.dgvInspecciones = new System.Windows.Forms.DataGridView();
            this.Coche = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.Hora = new System.Windows.Forms.DataGridViewTextBoxColumn();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.dgvInspecciones)).BeginInit();
            this.SuspendLayout();
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(49, 9);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(43, 13);
            this.label1.TabIndex = 0;
            this.label1.Text = "Camara";
            // 
            // cboCamaras
            // 
            this.cboCamaras.FormattingEnabled = true;
            this.cboCamaras.Location = new System.Drawing.Point(98, 6);
            this.cboCamaras.Name = "cboCamaras";
            this.cboCamaras.Size = new System.Drawing.Size(121, 21);
            this.cboCamaras.TabIndex = 1;
            // 
            // pictureBox1
            // 
            this.pictureBox1.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.pictureBox1.Location = new System.Drawing.Point(130, 43);
            this.pictureBox1.Name = "pictureBox1";
            this.pictureBox1.Size = new System.Drawing.Size(712, 395);
            this.pictureBox1.TabIndex = 2;
            this.pictureBox1.TabStop = false;
            // 
            // timer1
            // 
            this.timer1.Interval = 1;
            this.timer1.Tick += new System.EventHandler(this.timer1_Tick);
            // 
            // txtValor
            // 
            this.txtValor.Location = new System.Drawing.Point(169, 154);
            this.txtValor.Name = "txtValor";
            this.txtValor.Size = new System.Drawing.Size(100, 20);
            this.txtValor.TabIndex = 8;
            this.txtValor.Visible = false;
            // 
            // panelResultado
            // 
            this.panelResultado.Location = new System.Drawing.Point(169, 181);
            this.panelResultado.Name = "panelResultado";
            this.panelResultado.Size = new System.Drawing.Size(100, 100);
            this.panelResultado.TabIndex = 9;
            this.panelResultado.Visible = false;
            // 
            // btnIniciarInspecciones
            // 
            this.btnIniciarInspecciones.Location = new System.Drawing.Point(225, 6);
            this.btnIniciarInspecciones.Name = "btnIniciarInspecciones";
            this.btnIniciarInspecciones.Size = new System.Drawing.Size(75, 23);
            this.btnIniciarInspecciones.TabIndex = 10;
            this.btnIniciarInspecciones.Text = "Iniciar Inspecciones";
            this.btnIniciarInspecciones.UseVisualStyleBackColor = true;
            this.btnIniciarInspecciones.Click += new System.EventHandler(this.btnIniciarInspecciones_Click);
            // 
            // dgvInspecciones
            // 
            this.dgvInspecciones.AllowUserToAddRows = false;
            this.dgvInspecciones.AllowUserToDeleteRows = false;
            this.dgvInspecciones.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dgvInspecciones.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.Coche,
            this.Hora});
            this.dgvInspecciones.Location = new System.Drawing.Point(12, 43);
            this.dgvInspecciones.Name = "dgvInspecciones";
            this.dgvInspecciones.ReadOnly = true;
            this.dgvInspecciones.RowHeadersVisible = false;
            this.dgvInspecciones.Size = new System.Drawing.Size(112, 381);
            this.dgvInspecciones.TabIndex = 11;
            // 
            // Coche
            // 
            this.Coche.HeaderText = "Coche";
            this.Coche.Name = "Coche";
            this.Coche.ReadOnly = true;
            this.Coche.Width = 45;
            // 
            // Hora
            // 
            this.Hora.HeaderText = "Hora";
            this.Hora.Name = "Hora";
            this.Hora.ReadOnly = true;
            this.Hora.Width = 60;
            // 
            // frmInspecciones
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(873, 450);
            this.Controls.Add(this.dgvInspecciones);
            this.Controls.Add(this.pictureBox1);
            this.Controls.Add(this.btnIniciarInspecciones);
            this.Controls.Add(this.panelResultado);
            this.Controls.Add(this.txtValor);
            this.Controls.Add(this.cboCamaras);
            this.Controls.Add(this.label1);
            this.Name = "frmInspecciones";
            this.Text = "Inspector Virtual";
            this.Load += new System.EventHandler(this.Form1_Load);
            this.DoubleClick += new System.EventHandler(this.frmInspecciones_DoubleClick);
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox1)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.dgvInspecciones)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.ComboBox cboCamaras;
        private System.Windows.Forms.PictureBox pictureBox1;
        private System.Windows.Forms.Timer timer1;
        private System.Windows.Forms.TextBox txtValor;
        private System.Windows.Forms.Panel panelResultado;
        private System.Windows.Forms.Button btnIniciarInspecciones;
        private System.Windows.Forms.DataGridView dgvInspecciones;
        private System.Windows.Forms.DataGridViewTextBoxColumn Coche;
        private System.Windows.Forms.DataGridViewTextBoxColumn Hora;
    }
}

