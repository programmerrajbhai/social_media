class RegistrationModel{

   String firstname;
   String lastname;
   String email;
   String password;

   RegistrationModel(this.firstname, this.lastname, this.email, this.password);

   Map<String, dynamic> toMap(){
     return {
       'firstname': firstname,
       'lastname' : lastname,
       'email': email,
       'password': password
     };
   }


}