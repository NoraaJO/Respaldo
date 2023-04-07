using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Usuario
{
    public partial class WebForm3 : System.Web.UI.Page
    {
        string mainconn = @"Data Source=database-segunda.csuvznav9scq.us-east-1.rds.amazonaws.com,1433;
                                Initial Catalog=aaronWander;
                                User ID=admin;
                                Password=Wanderjose2"; // Se establece conexion
        string Usuario = "Tina";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (ddlClases.Items.Count != 3)
            {
                LlenarLista();
            }
        }

        protected void btnAregar_Click(object sender, EventArgs e)
        {
            //Se recuperan el nombre, precio y clase de articulos en sus respectivos cajas de texto y lista desplegables
            string Nombre = tbNombre.Text;
            string Precio = tbPrecio.Text;
            string Clase = ddlClases.SelectedValue;
            if (Nombre != "") //Se comprueba que el valor no sea vacio
            {
                if (Regex.IsMatch(Precio, @"^[0-9]+[,]{1}") && float.Parse(Precio) > 0) //Se comprueba que le precio tenga el formato permitido
                {
                    InsertarValores(Nombre, float.Parse(Precio), Clase); //Se envia los datos para insertar si los datos son correctos
                }
                else //Si el precio no tiene el formato, se envia un mensaje de error.
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "error6", "alert('Tiene que introducir número positivo en precio')", true);
            }
            else //Si el nombre es vacio se envia un mensaje de error.
                ScriptManager.RegisterStartupScript(this, this.GetType(), "error7", "alert('Tiene que insertar un nombre')", true);
        }
        protected void InsertarValores(string Nombre, float Precio, string ClaseArt)
        {
            string procedure = "[dbo].[Insertar_Articulo]"; //Nombre del procemdimiento almacenado
            int Result; // Variable para obtener el resultado de la inserción
            using (SqlConnection connection = new SqlConnection(mainconn)) //Instacian de conexión con la base de datos
            {
                connection.Open(); //Abre la conexión con la base.
                SqlCommand cmd = new SqlCommand(procedure, connection); //Crea el comando a ejecutar.
                cmd.CommandType = CommandType.StoredProcedure; //Se define como un store procedure
                cmd.Parameters.AddWithValue("@InNombre", Nombre); //Agrega el nombre como parametro del stored Procedured 
                cmd.Parameters.AddWithValue("@InPrecio", Precio); //Agrega el precio como parametro del stored Procedured
                cmd.Parameters.AddWithValue("@InClaseArticulo", ClaseArt); //Agrega la clase de articulo como parametro del stored Procedured 
                cmd.Parameters.AddWithValue("@InIp", Request.UserHostAddress);
                cmd.Parameters.AddWithValue("@InUsuarios", Usuario);
                cmd.Parameters.Add("@OutResultado", SqlDbType.Int).Direction = ParameterDirection.Output; //Se agrega el valor de salida del Stored procedure.
                cmd.ExecuteNonQuery(); //Ejecuta el procedimiento,
                Result = Convert.ToInt32(cmd.Parameters["@OutResultado"].Value); //Se obtiene el valor retornado por el store Procedure
                if (Result == 1) //Si el nombre no es valido
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "error1", "alert('Nombre no valido')", true);
                }
                else if (Result == 2) //Si el precio no es valido
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "error2", "alert('Precio no valido')", true);
                }
                else if (Result == 3) //Si la clase de articulo no es valido
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "error3", "alert('Clase de articulo no valido')", true);
                }
                else if (Result == 4) //Si el articulo ya se encuentra en la base de datos.
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "error4", "alert('Articulo con nombre duplicado')", true);
                }
                else //Si se agrega, nada más se retorna y se vuelve a la página principal.
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Completado", "alert('Articulo agregado')", true);
                    Response.Redirect("Inicio.aspx?result=1");
                }
                connection.Close(); //Se cierra la conexión.
            }
        }

        protected void LlenarLista()
        {
            SqlConnection sqlconn = new SqlConnection(mainconn);
            SqlCommand sqlcomm = new SqlCommand("listar_claseArticulos", sqlconn); // Se prepara para ejecutar el SP
            sqlcomm.CommandType = CommandType.StoredProcedure;
            sqlconn.Open();
            SqlDataReader reader = sqlcomm.ExecuteReader();
            while (reader.Read()) // Mientras que se puede leer
            {
                string nombre = reader["Nombre"].ToString(); // Se guarda el nombre
                ddlClases.Items.Add(nombre); // Se agrega a las opciones
            }
            reader.Close();
            reader.Dispose();
            sqlconn.Close();
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            Response.Redirect("Inicio.aspx");
        }
    }
}

