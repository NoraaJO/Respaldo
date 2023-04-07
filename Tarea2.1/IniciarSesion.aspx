<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="IniciarSesion.aspx.cs" Inherits="Usuario.WebForm1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <style type="text/css">
        .auto-style1 {
            height: 218px;
            width: 504px;
            background-color: #FFFFFF;
        }
        .auto-style2 {
            margin-left: 60px;
            margin-top: 0px;
        }
        .auto-style3 {
            margin-left: 60px;
            margin-top: 0px;
            margin-bottom: 0px;
        }
        .auto-style4 {
            margin-left: 361px;
            margin-top: 16px;
            margin-bottom: 0px;
        }
        .auto-style5 {
            font-size: xx-large;
        }
        .auto-style6 {
            color: #FF0000;
        }
    </style>
</head>
<body style="height: 226px; width: 511px">
    <form id="form1" runat="server">
        <div class="auto-style1" style="border-style: solid; border-width: thin">
            <strong><span class="auto-style5">&nbsp;USER NAME : </span></strong>
            <asp:TextBox ID="Nombre" runat="server" CssClass="auto-style3" Width="250px"></asp:TextBox>
&nbsp;&nbsp;
            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="Nombre" CssClass="auto-style6" ErrorMessage="Se requiere un UserName"></asp:RequiredFieldValidator>
            <br />
            <br />
            <strong><span class="auto-style5">&nbsp;PASSWORD :</span></strong><asp:TextBox ID="Contrasena" runat="server" CssClass="auto-style2" TextMode="Password" Width="250px"></asp:TextBox>
&nbsp;&nbsp;&nbsp;
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="Contrasena" CssClass="auto-style6" ErrorMessage="Se requiere un Password"></asp:RequiredFieldValidator>
            <br />
            <br />
            <asp:Button ID="Aceptar" runat="server" CssClass="auto-style4" OnClick="Button1_Click" Text="ACEPTAR" />
        </div>
    </form>
</body>
</html>
