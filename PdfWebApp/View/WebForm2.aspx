﻿<%@ Page Language="C#" AutoEventWireup="false" CodeBehind="WebForm2.aspx.cs" Inherits="PdfWebApp.View.WebForm2" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>PDF UPLOAD</title>
    <link rel="stylesheet" href="../Content/bootstrap.css" />
    <link rel="stylesheet" href="StyleSheet.css" />
</head>
<body>

    <!-- particles.js container -->
    <div id="particles-js"></div>
    <section class="pt-5">
        <div class="container">
            <div class="row">
                <div class="col-auto mx-auto bg-white text-center">
                    <img id="logo-base" src="src/logo-01-1.png" class="img-fluid" />
                    <h1 class="text-danger">PDF COMPARER</h1>
                    <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModal">
                        Upustvo za koristenje
                    </button>
                </div>
            </div>

            <div class="row">
                <div class="col-md-12">
                    <form runat="server" method="post" enctype="multipart/form-data" action="WebForm2.aspx" id="form1">
                        <div class="form-group files">
                            <label>Upload Your File </label>
                            <asp:FileUpload runat="server" ID="UploadPDFs" AllowMultiple="true" />
                        </div>
                        <asp:Button class="btn btn-primary" runat="server" ID="uploadedFile" Text="Upload" OnClick="uploadFile_Click" />
                        <asp:Button class="btn btn-warning" runat="server" ID="buttonCalculate" OnClick="calculate_Click" Text="Calculate" />
                        <asp:Button class="btn btn-danger" runat="server" ID="buttonReset" OnClick="btnReset_Click" Text="Reset" />
                        <div>
                            <asp:Label ID="listofuploadedfiles" runat="server" />
                        </div>
                        <div>
                            <asp:Label ID="lblError" class="text-danger" runat="server" />
                        </div>
                    </form>
                </div>
                <div class="col-md-12 pt-3 text-center">
                    <div class="progress">
                        <div runat="server" id="progressBar" class="progress-bar progress-bar-striped" role="progressbar" style="width: 0%" aria-valuenow="10" aria-valuemin="0" aria-valuemax="100"></div>
                    </div>
                    <p runat="server" id="statusBar"></p>
                    <h1 runat="server" class="text-primary" id="result"></h1>
                </div>
            </div>
        </div>
    </section>

    <!-- Button trigger modal -->


    <!-- Modal -->
    <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Upustvo</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    Odaberite dva pdf fajla koja zelite da uporedite. Prvo odaberite jedan, pa kliknite dugme UPLOAD, a zatim odaberite drugi i opet kliknite UPLOAD.<br />
                    Ako ste dobro uradili ispod dugmeta ce da pokaze da su dva fajla uploadovana.<br />
                    Nakon sto su fajlovi uploadovani mozete da pritisnete CALCULATE zuto dugme i pricekajte dok ne dobijete rezultat koji ce biti ispisan na dnu ekrana plavom bojom.<br />
                    Kada ste gotovi, pritisnite crveno dugme RESET da bi se fajlovi obrisali sa servera.<br />

                </div>
                <div class="modal-footer">
                    <div class="col">
                        <div class="float-left">
                            <p class="lead">Autor: Viktor Lekic</p>
                        </div>
                        <div class="float-right">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>


    <script src="../Scripts/jquery-3.0.0.min.js"></script>
    <script src="../Scripts/umd/popper.min.js"></script>
    <script src="../Scripts/bootstrap.min.js"></script>
    <script src="../Scripts/particles.min.js"></script>

    <script>

        //only pdf files by default
        $(document).ready(function () {
            document.getElementById("<%=UploadPDFs.ClientID %>").setAttribute('accept', 'application/pdf');
        })

        particlesJS("particles-js", {
            "particles": {
                "number": {
                    "value": 80,
                    "density": {
                        "enable": true,
                        "value_area": 800
                    }
                },
                "color": {
                    "value": "#000000"
                },
                "shape": {
                    "type": "circle",
                    "stroke": {
                        "width": 0,
                        "color": "#000000"
                    },
                    "polygon": {
                        "nb_sides": 5
                    },
                    "image": {
                        "src": "img/github.svg",
                        "width": 100,
                        "height": 100
                    }
                },
                "opacity": {
                    "value": 0.5,
                    "random": false,
                    "anim": {
                        "enable": false,
                        "speed": 1,
                        "opacity_min": 0.1,
                        "sync": false
                    }
                },
                "size": {
                    "value": 3,
                    "random": true,
                    "anim": {
                        "enable": false,
                        "speed": 40,
                        "size_min": 0.1,
                        "sync": false
                    }
                },
                "line_linked": {
                    "enable": true,
                    "distance": 150,
                    "color": "#000000",
                    "opacity": 0.4,
                    "width": 1
                },
                "move": {
                    "enable": true,
                    "speed": 3,
                    "direction": "none",
                    "random": false,
                    "straight": false,
                    "out_mode": "out",
                    "bounce": false,
                    "attract": {
                        "enable": false,
                        "rotateX": 600,
                        "rotateY": 1200
                    }
                }
            },
            "interactivity": {
                "detect_on": "canvas",
                "events": {
                    "onhover": {
                        "enable": false,
                        "mode": "repulse"
                    },
                    "onclick": {
                        "enable": false,
                        "mode": "push"
                    },
                    "resize": true
                },
                "modes": {
                    "grab": {
                        "distance": 400,
                        "line_linked": {
                            "opacity": 1
                        }
                    },
                    "bubble": {
                        "distance": 400,
                        "size": 40,
                        "duration": 2,
                        "opacity": 8,
                        "speed": 3
                    },
                    "repulse": {
                        "distance": 200,
                        "duration": 0.4
                    },
                    "push": {
                        "particles_nb": 4
                    },
                    "remove": {
                        "particles_nb": 2
                    }
                }
            },
            "retina_detect": true
        });
    </script>

</body>
</html>
