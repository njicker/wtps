<?php defined('BASEPATH') or exit('No direct script access allowed');?>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset ="utf-8">
        <meta name ="viewport" content ="width=device-width, initial-scale=1">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Roboto:ital,wght@0,400;0,900;1,700&display=swap" rel="stylesheet"> 
        <script src="<?= $assets ?>js/jquery.js"></script>
        <title>Halaman Login</title>
    </head>
    <body>
        <section class="vh-100 ">
            <div class="container-fluid"style="min-height: 100vh;">
                <div class="row">
                    <div class="col-md-7 text-center" id="label-section">
                    <!-- <div class="col-md-7 text-center" id="label-section" style="min-height: 100vh; background-color: cornflowerblue;"> -->
                        <img src="<?=base_url('themes/default/admin/assets/images/logo_transparent.png')?>" class="img-logo" alt="logo">
                        <!-- <div class="text text-bold;">Productifity.</div> -->
                        <!-- <div class="row">
                            <label class="logo-text">Productifity</label>
                        </div>
                        <div class="row">
                            <label class="logo-subtext">Management System</label>
                        </div> -->
                    </div>
                    <div class="col-md-5" style="background-color: #f8f9fa; padding-top: 40px;">
                        <div class="container-fluid">
                            <div class="col-md-8 offset-2 pt-5">
                                <img src="<?=base_url('themes/default/admin/assets/images/logo_wtps.png')?>" class="img-login" alt="logo">
                                <?php if($error){ ?>
                                    <div class="alert alert-danger">
                                        <!-- <button data-dismiss="alert" class="close" type="button">×</button> -->
                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" style="float:right;" onclick="$(this).closest('div').remove()"></button>
                                        <ul class="list-group"><?=$error?></ul>
                                    </div>
                                <?php } ?>
                                <label class="login-info mb-3">Mohon dapat login dengan akun yang sudah diberikan oleh admin</label>
                                <?php echo admin_form_open('auth/login', 'class="login" data-toggle="validator"'); ?>
                                    <div class="form-group mb-3">
                                        <label for="alamatEmail" class ="form-label">Username</label>
                                        <input type ="text" class="form-control" id="alamatEmail" name="identity">
                                    </div>
                                    <div class="form-group mb-3">
                                        <label for ="Password" class ="form-label">Silahkan masukan password anda</label>
                                        <input type ="password" class="form-control" id="Password" name="password">
                                    </div>
                                    <!-- <div class="form-check">
                                        <input type="checkbox" class="form-check-input" id="remember">
                                        <label class ="form-check-label" for="remember">Remember Me</label>
                                    </div> -->
                                    <div class="form-group">
                                        <button type="sumbit" class="btn btn-primary form-control">Login</button>
                                    </div>
                                    <!-- <div class="mb-3">
                                        <a class="" href="#">Forgot Password</a>
                                    </div> -->
                                    <!-- <div class="card">
                                        <div class="card-header">
                                            <strong>Admin login credentials</strong>
                                        </div>
                                        <ul class="list-group list-group-flush">
                                            <li class="list-group-item"><strong>Email: </strong> superadmin@productify.com</li>
                                            <li class="list-group-item" ><strong>Password: </strong> productify2022</li>
                                        </ul>
                                    </div> -->
                                <?php echo form_close(); ?>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </body>
    <style>
        .login-info{
            font-weight: 700;
        }
        body{
            color: #777;
            font-family: 'Roboto', sans-serif;
        }
        #label-section{
            color: #fafafa;
            height: 100vh;
            background-color: #273573;
        }
        .logo-text{
            font-size: 50px;
            text-transform: uppercase;
            font-weight: bold;
            letter-spacing: 3px;
            font-style: italic;
        }
        .logo-subtext{
            font-size: 20px;
            text-transform: uppercase;
            font-weight: normal;
            letter-spacing: 9px;
        }
        .img-logo{
            width: 70%;
            position: relative;
            padding-top: calc(50vh - 80px);
        }
        .img-login{
            width: 200px;
            margin-bottom: 20px;
        }
    </style>
</html>
