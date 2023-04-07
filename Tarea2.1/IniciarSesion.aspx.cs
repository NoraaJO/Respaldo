using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Drawing.Printing;
using System.Runtime.Remoting.Messaging;

namespace Usuario
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e) // Accion al aceptar en el FORM
        {
            string mainconn = @"Data Source=database-segunda.csuvznav9scq.us-east-1.rds.amazonaws.com,1433;
                                Initial Catalog=aaronWander;
                                User ID=admin;
                                Password=Wanderjose2"; // Se establece conexion con la BD

            SqlConnection sqlconn = new SqlConnection(mainconn);
            sqlconn.Open();
            string checkuser = "SELECT count(*) FROM dbo.Usuario WHERE UserName='" + Nombre.Text + "'"; // Se selecciona el usuario con el userName
            SqlCommand sqlcomm = new SqlCommand(checkuser, sqlconn);
            int temp = Convert.ToInt32(sqlcomm.ExecuteScalar().ToString());
            sqlconn.Close();

            if (temp == 1) // Si el usuario existe
            {
                sqlconn.Open();
                string checkpassword = "SELECT Password FROM dbo.Usuario WHERE UserName='" + Nombre.Text + "'"; // Se obtiene el password de la BD
                SqlCommand sqlpasscomm = new SqlCommand(checkpassword, sqlconn);
                string password = sqlpasscomm.ExecuteScalar().ToString().Replace(" ", "");
                if (password == Contrasena.Text) // Si la password colocada y la de la BD es igual
                {
                    Response.Redirect("WebForm2.aspx"); // Me redirige a la pagina inicial
                }
                else
                {
                    Response.Write("Combinación de usuario / password no existe en la BD"); // Si no es igual no me deja avanzar
                }
            }
            else
            {
                Response.Write("Combinación de usuario / password no existe en la BD");
            }
        }
    }
}