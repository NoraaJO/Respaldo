<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Inicio.aspx.cs" Inherits="Usuario.WebForm2" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <style type="text/css">
        .auto-style1 {
            width: 100%;
        }
        .auto-style7 {
            width: 816px;
            height: 55px;
        }
        .auto-style8 {
            height: 55px;
        }
        .auto-style9 {
            margin-left: 40px;
        }
        .auto-style10 {
            margin-left: 36px;
            margin-right: 0px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <table class="auto-style1">
                <tr>
                    <td colspan="2">
                        <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Names="Arial" Font-Size="XX-Large" Text="Articulos"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style7">
                        <asp:Label ID="Label2" runat="server" Font-Bold="True" Font-Names="Arial" Font-Size="Large" Text="Nombre"></asp:Label>
                        <br />
                        <asp:TextBox ID="tbfiltNombre" runat="server" Height="29px" Width="402px"></asp:TextBox>
                    </td>
                    <td class="auto-style8">
                        <asp:Button ID="btFiltNombre" runat="server" Font-Bold="True" Font-Names="Arial" Font-Size="Large" Height="41px" Text="Filtrar Por Nombre" Width="314px" OnClick="btFiltNombre_Click" />
                    </td>
                </tr>
                <tr>
                    <td class="auto-style7">
                        <asp:Label ID="label3" runat="server" Font-Bold="True" Font-Names="Arial" Font-Size="Large" Text="Cantidad"></asp:Label>
                        <br />
                        <asp:TextBox ID="tbfiltCant" runat="server" Height="29px" Width="402px"></asp:TextBox>
                    </td>
                    <td class="auto-style8">
                        <asp:Button ID="btFiltCant" runat="server" Font-Bold="True" Font-Names="Arial" Font-Size="Large" Height="41px" Text="Filtrar Por Cantidad" Width="314px" OnClick="btFiltCant_Click" />
                    </td>
                </tr>
                <tr>
                    <td class="auto-style7">
                        <asp:Label ID="label4" runat="server" Font-Bold="True" Font-Names="Arial" Font-Size="Large" Text="Clase Articulo"></asp:Label>
                        <br />
                        <asp:DropDownList ID="DdClaseList" runat="server" Height="50px" Width="332px" CssClass="auto-style9">
                        </asp:DropDownList>
                    </td>
                    <td class="auto-style8">
                        <asp:Button ID="btFiltClase" runat="server" Font-Bold="True" Font-Names="Arial" Font-Size="Large" Height="41px" Text="Filtrar Por Clase" Width="314px" OnClick="btFiltClase_Click" />
                    </td>
                </tr>
                <tr>
                    <td class="auto-style7">
                        &nbsp;&nbsp;&nbsp;
                        <asp:Button ID="btInsertar" runat="server" Font-Bold="True" Font-Names="Arial" Font-Size="Large" Height="41px" Text="Insertar" Width="314px" OnClick="btInsertar_Click" CssClass="auto-style10" />
                    </td>
                    <td class="auto-style8">
                        <asp:Button ID="btSalir" runat="server" Font-Bold="True" Font-Names="Arial" Font-Size="Large" Height="41px" Text="Salir" Width="314px" OnClick="btSalir_Click" />
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <asp:GridView ID="GridArticulos" runat="server" Height="205px" Width="1218px">
                        </asp:GridView>
                    </td>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>