public class CI_Validaciones {
  
  public static boolean infotributariaecuador(string tipocuenta, string cedularuc,string tipoidentificacion, id tiporegistro) {
      boolean resultado;
      if((tipocuenta==null || tipoidentificacion==null) && tiporegistro=='Prospecto principal') { // Ninguno y Ninguno
          resultado = false;
      }
      else if(tipocuenta=='1' && tipoidentificacion=='2' && cedularuc!=null) { // Natural y Cédula
          resultado= validateCedula(cedularuc);
      }
      else if(tipocuenta=='2' && tipoidentificacion=='1' && cedularuc!=null) { // Jurídico y  Ruc
          resultado= validateRUC(cedularuc);  
      }
      else if(tipocuenta=='1' && tipoidentificacion=='1') { // Natural y Ruc
          resultado = false;        
      }
      else if(tipocuenta=='2' && tipoidentificacion=='2') { // Jurídico y Cédula
          resultado = false;        
      }
      return resultado;   
  }
  
  public static boolean infotributariaecuadorconyuge(string tipoidentificacion, string cedula) {
      boolean resultado;
      if(tipoidentificacion=='2' && cedula!=null) {
          resultado = validateCedula(cedula);
      }      
      return resultado;     
  }
  
  public static boolean validateCedula(string cedula){
      if(cedula.length()!=10) {
          return false;
      } else {
          try {
              if(Integer.valueOf(cedula.substring(0,2))>24) {
                  system.debug('primeros dos son mayores a 24');
                  return false;
              } else {
                  if(Integer.valueOf(cedula.substring(2,3))>6) {
                      system.debug('tercer digito mayor a 6');
                      return false;
                  } else {
                      integer sumatoria = 0;
                      integer coeficiente = 2;
                      for(integer i = 0 ;i<cedula.length()-1;i++) {
                          integer numero =Integer.valueOf(cedula.substring(i,i+1));
                          sumatoria += numero*coeficiente>9?numero*coeficiente-9:numero*coeficiente;
                          if(coeficiente == 2) {
                              coeficiente = 1;
                          } else {
                              coeficiente = 2;
                          }
                       }
                       integer proximaDecena =0;
                       
                       while(proximaDecena<sumatoria){
                           proximaDecena+=10;
                       }
                       if((proximaDecena-sumatoria)==Integer.valueOf(cedula.substring(cedula.length()-1))){
                           return true;
                       }else{
                           system.debug('no cuadran, suma: '+(proximaDecena-sumatoria)+' ultimo dígito: '+Integer.valueOf(cedula.substring(cedula.length()-1)));
                           return false;
                       }
                   }
               }
          } catch(Exception e) { system.debug('Error de conversión de datos probablemente, '+e.getMessage()); return false; }
      }
   }
   public static boolean validateRUC(string ruc){
       if(ruc.length()!=13){
           return false;
       } else {
           try {
               if(Integer.valueOf(ruc.substring(2,3))==9){
                   system.debug('Institución Pública');
                   integer sumatoria = 0;
                   
                   List<Integer> coeficientes = new List<Integer>();
                   coeficientes.add(4); 
                   coeficientes.add(3); 
                   coeficientes.add(2); 
                   coeficientes.add(7); 
                   coeficientes.add(6); 
                   coeficientes.add(5); 
                   coeficientes.add(4); 
                   coeficientes.add(3); 
                   coeficientes.add(2);
                   
                   for(Integer i=0;i<9;i++) {
                       integer numero =Integer.valueOf(ruc.substring(i,i+1));
                       sumatoria+= numero*coeficientes[i];
                   }
                   
                   integer mod=Math.mod(sumatoria, 11)==10?0:Math.mod(sumatoria, 11);
                   integer digitoVerificador = Integer.valueOf(ruc.substring(9,10));
                   if((11-mod)==digitoVerificador) {
                       return true;
                   } else{ system.debug('no cuadran, suma: '+(11-mod)+' ultimo dígito: '+digitoVerificador); return false; }
               }else if(Integer.valueOf(ruc.substring(2,3))==6) {
                   system.debug('Persona Jurídica o Natural');
                   integer sumatoria = 0;
                   
                   List<Integer> coeficientes = new List<Integer>();
                   coeficientes.add(3); 
                   coeficientes.add(2); 
                   coeficientes.add(7); 
                   coeficientes.add(6); 
                   coeficientes.add(5); 
                   coeficientes.add(4); 
                   coeficientes.add(3); 
                   coeficientes.add(2);
                   
                   for(Integer i=0;i<8;i++) {
                       integer numero =Integer.valueOf(ruc.substring(i,i+1));
                       system.debug('numero '+numero);
                       sumatoria+= numero*coeficientes[i];
                       system.debug('sumatoria '+sumatoria);
                   }
                   
                   integer mod=Math.mod(sumatoria, 11)==10?0:Math.mod(sumatoria, 11);
                   system.debug('mod '+mod);
                   integer digitoVerificador = Integer.valueOf(ruc.substring(8,9));
                   if((11-mod)==digitoVerificador){ return true;
                   } else if(Integer.valueOf(ruc.substring(2,3))<6) {
                       system.debug('no cuadran, suma: '+(11-mod)+' ultimo dígito: '+digitoVerificador);
                       return false;
                   } else {
                       system.debug('Tercer dígito inválido '+Integer.valueOf(ruc.substring(2,3))+' Se validara como cedula de persona natural');
                       return validateCedula(ruc.substring(0,10));
                   }
               } else {
                   return validateCedula(ruc.substring(0,10));
               }
           } catch(Exception e) {
               system.debug('Error de conversión de datos probablemente, '+e.getMessage());
               system.debug('Error de conversión de datos probablemente, '+e.getLineNumber());
               return false;
           }
       }
   }

}