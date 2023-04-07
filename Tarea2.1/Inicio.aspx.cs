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
    public partial class WebForm2 : System.Web.UI.Page
    {
        string Usuario = "Adam";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (DdClaseList.Items.Count != 3)
                cargarClaseArticulos();
            string cantidad = Request.QueryString["cantidad"];
            if (cantidad != null)
                listarTabla(cantidad, 1);
            else
            {
                cantidad = Request.QueryString["nombre"];
                if (cantidad != null)
                    listarTabla(cantidad, 0);
                else
                {
                    cantidad = Request.QueryString["clase"];
                    if (cantidad != null)
                        listarTabla(cantidad, 2);
                    else
                    {
                        listarTabla(cantidad, 3);
                    }
                }
            }
            cantidad = Request.QueryString["result"];
            if (cantidad != null)
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Result", "alert('Se agrego el articulo')", true);
        }

        protected void listarTabla(string dato, int accion)
        {
            string mainconn = @"Data Source=database-segunda.csuvznav9scq.us-east-1.rds.amazonaws.com,1433;
                                Initial Catalog=aaronWander;
                                User ID=admin;
                                Password=Wanderjose2"; // Se establece conexion

            SqlConnection sqlconn = new SqlConnection(mainconn);
            SqlCommand sqlcomm;

            if (accion == 0)
            {
                sqlcomm = new SqlCommand("[dbo].[filtrar_Nombre]", sqlconn);
                sqlcomm.CommandType = CommandType.StoredProcedure;
                sqlcomm.Parameters.AddWithValue("@InNombre", dato); // Se filtra por nombre
            }
            else if (accion == 1)
            {
                sqlcomm = new SqlCommand("[dbo].[Filtrar_Cantidad]", sqlconn);
                sqlcomm.CommandType = CommandType.StoredProcedure;
                sqlcomm.Parameters.AddWithValue("@InCantidad", int.Parse(dato)); // Se filtra por cantidad
            }
            else if (accion == 2)
            {
                sqlcomm = new SqlCommand("[dbo].[Filtrar_ClaseArticulo]", sqlconn);
                sqlcomm.CommandType = CommandType.StoredProcedure;
                sqlcomm.Parameters.AddWithValue("@InClaseArticulo", dato); // Se filtra por clase
            }
            else
            {
                sqlcomm = new SqlCommand("[dbo].[listar_Articulos]", sqlconn);
                sqlcomm.CommandType = CommandType.StoredProcedure; // Si no se filtra, entonces muestra los datos
            }
            if (accion < 3)
            {
                sqlcomm.Parameters.AddWithValue("@InIp", Request.UserHostAddress);
                sqlcomm.Parameters.AddWithValue("@InUsuarios", Usuario);
            }
            sqlconn.Open();
            SqlDataAdapter sda = new SqlDataAdapter(sqlcomm);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            GridArticulos.DataSource = dt; // Se rellena el grid con los datos, segun la accion tomada
            GridArticulos.DataBind();
            sqlconn.Close();
        }

        protected void cargarClaseArticulos()
        {
            string mainconn = @"Data Source=database-segunda.csuvznav9scq.us-east-1.rds.amazonaws.com,1433;
                                Initial Catalog=aaronWander;
                                User ID=admin;
                                Password=Wanderjose2"; // Se establece conexion

            SqlConnection sqlconn = new SqlConnection(mainconn);
            SqlCommand sqlcomm = new SqlCommand("listar_claseArticulos", sqlconn); // Se prepara para ejecutar el SP
            sqlcomm.CommandType = CommandType.StoredProcedure;
            sqlconn.Open();
            SqlDataReader reader = sqlcomm.ExecuteReader();
            while (reader.Read()) // Mientras que se puede leer
            {
                string nombre = reader["Nombre"].ToString(); // Se guarda el nombre
                DdClaseList.Items.Add(nombre); // Se agrega a las opciones
            }
            reader.Close();
            reader.Dispose();
            sqlconn.Close();
        }

        protected void btFiltCant_Click(object sender, EventArgs e)
        {
            string cantidad = tbfiltCant.Text; // Se recibe la cantidad puesta en la caja

            if (Regex.IsMatch(cantidad, @"\d") && int.Parse(cantidad) >= 0) // Si la cantidad es un valor valido
            {
                Response.Redirect("Inicio.aspx?cantidad=" + cantidad); // Redirige con el valor de cantidad
            }  
            else if (cantidad == "") // Si no se coloca valor
            {
                Response.Redirect("Inicio.aspx"); // Redirige con todos los datos
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "err_Cant", "alert('Tienes que introducir un numero entero')", true); // Error si la cantidad no es valida
            }
        }

        protected void btFiltNombre_Click(object sender, EventArgs e)
        {
            string nombre = tbfiltNombre.Text; // Se obtiene lo que se escribio en el texto
            if (nombre.Length > 0)
                Response.Redirect("Inicio.aspx?nombre=" + nombre); // Si no esta vacia se filtra
            else
                Response.Redirect("Inicio.aspx"); // Si esta vacia se despliega todo
        }

        protected void btFiltClase_Click(object sender, EventArgs e)
        {
            Response.Redirect("Inicio.aspx?clase=" + DdClaseList.SelectedValue); // Filtra por la opcion de la caja
        }

        protected void btInsertar_Click(object sender, EventArgs e)
        {
            Response.Redirect("InsertarArtic.aspx"); // Me redirige a la pagina de insertar
        }

        protected void btSalir_Click(object sender, EventArgs e)
        {
            Response.Redirect("IniciarSesion.aspx"); // Me redirige a la pagina de usuario
        }
    }
}