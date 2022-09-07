import React, { useState } from "react";
import { fetchData, sendData } from "../api";

const LoginPage = () => {
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const handleLogin = async () =>{

        const user = await {auth: {"email": email, "password": password}};
        let res = await sendData("user_token",user);
        console.log(res);
        localStorage.setItem('user_token',res.jwt);


  }
  const validateForm =() => {

    return email.length > 0 && password.length > 0;

  }
  return (
    <div>
    <section class="vh-50 gradient-custom">
    <div class="container py-5 h-25">
      <div class="row d-flex justify-content-center align-items-center h-25">
        <div class="col-12 col-md-8 col-lg-6 col-xl-5">
          <div
            class="card bg-success text-white"
          >
            <div class="card-body px-5 text-center">
              <div class="mb-md-5 mt-md-4">
                <h2 class="fw-bold mb-2 text-uppercase">Login</h2>
                <p class="text-white-50 mb-5">
                  Please enter your login and password!
                </p>

                <div class="form-outline form-white mb-4">
                  <input
                    type="email"
                    id="typeEmailX"
                    class="form-control form-control-lg"
                    onChange={(e) => setEmail(e.target.value)}
                  />
                </div>

                <div class="form-outline form-white mb-4">
                  <input
                    type="password"
                    id="typePasswordX"
                    class="form-control form-control-lg"
                    onChange={(e) => setPassword(e.target.value)}
                  />
                </div>
                <button
                  class="btn btn-outline-light btn-lg px-5"
                  disabled={!validateForm()}
                  onClick={handleLogin}
                >
                  Login
                </button>
              </div>

              <div></div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>
    </div>
  );
};

export default LoginPage;
