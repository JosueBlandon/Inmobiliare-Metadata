public class extensionCotizacion {
        
    public ApexPages.StandardController controller {get;set;}
    
    //Filtros iniciales
    public Proyecto__c proyecto {get;set;}
    public String proyectoSeleccionado {get;set;}
    public List<Proyecto__c> listaProyectos {get;set;}
    public List<SelectOption> opcionesProyecto {get;set;}
    
    public Urbanizacion__c urbanizacion {get;set;} 
    public String urbanizacionSeleccionada {get;set;}
    public String urbanizacionSeleccionadaModelo {get;set;}
    public List<Urbanizacion__c> listaUrbanizaciones {get;set;}
    public List<SelectOption> opcionesUrbanizacion {get;set;}
    
    public Manzana__c manzana {get;set;}
    public String manzanaSeleccionada {get;set;}
    public List<Manzana__c> listaManzanas {get;set;}
    public List<SelectOption> opcionesManzana {get;set;}
    
    public Lote__c inmueble {get;set;}
    public String inmuebleSeleccionado {get;set;}
    public List<Lote__c> listaInmuebles {get;set;}
    public List<SelectOption> opcionesInmueble {get;set;}
    public List<PromocionFeedResponse> listaPromociones {get;set;}
    public List<PromocionFeedResponse> listaAdicionales {get;set;}
    public List<PromocionFeedResponse> listaHistoricos {get;set;}
    
    public Modelo__c modelo {get;set;}
    public String modeloSeleccionado {get;set;}
    public List<Modelo__c> listaModelos {get;set;}
    public List<SelectOption> opcionesModelo {get;set;}
    public User usuario {get;set;} 
    
    // Fin de filtros iniciales
    
    public List<Implantacion__c> listaImplantacion {get;set;}
    
    //public string categoriaBienFilter {get;set;}
    //public List<SelectOption> opcionesTipoVenta {get;set;}
    
    public String loteFiltro {get;set;}
    public String ManzanaFiltro {get;set;}
    public Integer cantidadLineas {get;set;}
    public Opportunity oportunidad {get;set;}
    public Propiedad propiedadSeleccionada {get;set;}
    public Cotizacion__c cotizacion {get;set;}
    public List<Propiedad> listaPropiedad {get;set;}
    public Proyecto__c empresa {get;set;}
    public Boolean NoModificable {get;set;}
    public Boolean IngresaPreferencial {get;set;}
    public Boolean NoFinanciable {get;set;}
    
    public String hidesave {get;set;}
    
    public extensionCotizacion(ApexPages.StandardController stdController) {
        
        List<String> fields = new List<String>();
        fields.add('Oportunidad__c');
        fields.add('CI_Oportunidad_PD__c');    
        fields.add('Precio_Lista__c');
        fields.add('Monto_Descuento__c');
        fields.add('Tipo_Financiamiento__c');
        fields.add('Implantaci_n_Principal__c');
        fields.add('Valor_Contrato__c');
        fields.add('Valor_de_Entrada__c');
        fields.add('Valor_Saldo__c');
        fields.add('Porcentaje_Cuota_Entrada__c');
        fields.add('Plazo_Cuota_Entrada__c');
        fields.add('Plazo_Entrada_Saldo__c');
        fields.add('Fecha_Cuota_Entrada__c');
        fields.add('Fecha_Cuota_Saldo__c');
        fields.add('Tasa_De_Interes_anual__c');
        fields.add('Monto_Base__c');
        fields.add('Porcentaje_Cuota_Inicial__c');
        fields.add('Institucion_Financiera__c');
        fields.add('Tipo_de_Venta__c');
        fields.add('Revisado__c');
        fields.add('Estado__c');
        fields.add('Lote__c');
        fields.add('Descuento_Porcentaje__c');
        fields.add('Implantaci_n_Principal__r.Lote__r.CI_Proyecto__c');
        fields.add('CI_Proyecto__c');
        fields.add('Ingresa_Preferencial__c');
        fields.add('CreatedDate');
        if(!test.isRunningTest()) { 
            stdController.addFields(fields);
        }   
        
        controller = stdController;
        cotizacion = (Cotizacion__c)controller.getRecord();
        cantidadLineas = 10;
        IngresaPreferencial = false;
        NoModificable = false;
        NoFinanciable = false;
        OpcionesModelo = new List<SelectOption>();
        
        usuario = [SELECT Id, profile.Name FROM User WHERE Id=:system.UserInfo.getUserId()];
        
        if(cotizacion.Id !=null){
               
            //Inicio validando que exista proceso de aprobación
            list<ProcessInstance> existingApprovals = [SELECT Id, TargetObjectId, status FROM ProcessInstance WHERE TargetObjectId =: cotizacion.id order by createdDate Desc];
            	//Ocultar botón *Guardar* si la cotización preferencial está en aprobación
            if(existingApprovals.size() > 0 && existingApprovals[0].status == 'Pending') {
                hidesave = 'display:none;';	   
            } else {
            	hidesave = 'display:row;';	  	   
            }
            //Fin validando que exista proceso de aprobación
            
            oportunidad = [SELECT Id, Name, Account.Name, Account.CI_Email__c, Account.CI_Movil__c, Account.CI_Identificacion__c, Account.CI_celular__c, Fecha_de_Reserva__c, Account.CI_Tipo_Identi__c, Estado_de_Venta__c, 
                           Estado_de_Aprobacion__c, Owner.CI_Nombre_Funcion__c, Cotizacion__c, StageName 
                           FROM Opportunity 
                           WHERE Id = :cotizacion.Oportunidad__c];
            // Lista de Proyectos
            listaProyectos = [SELECT ID, Name, Minimo_Reserva__c, CI_Porcentaje_Entrada__c, Maximo_de_Cuotas__c FROM Proyecto__c /*Where Name=:oportunidad.Owner.CI_Nombre_Funcion__c*/];
            opcionesProyecto = new List<SelectOption>();
            for(Proyecto__c item:listaProyectos) {
                opcionesProyecto.add(new SelectOption(item.Id,item.Name));
                if(item.Id==cotizacion.CI_Proyecto__c){
                    //proyecto = item;
                    proyectoSeleccionado = cotizacion.Implantaci_n_Principal__r.Lote__r.CI_Proyecto__c;
                }
            }
            NoModificable = true;
            NoFinanciable = true;
            if(Oportunidad.Estado_de_Venta__c!='Vendido' && Oportunidad.Estado_de_Aprobacion__c=='Aprobado'){
                NoModificable = false;
                NoFinanciable = false;
            }
            
            if(!usuario.profile.Name.contains('Asesor') && oportunidad.Cotizacion__c == null){
                NoModificable = false;
            }
            
            if(usuario.profile.Name != 'Asesor de Ventas' && Oportunidad.Estado_de_Venta__c!='Vendido' && Oportunidad.Estado_de_Aprobacion__c!='Aprobado') {
                NoModificable = false;
            }
            
            Sales_SLA_config__mdt configSLA = 
                [SELECT MasterLabel, Valor_de_Comparacion__c FROM Sales_SLA_config__mdt WHERE QualifiedApiName='MOD1_Dias_modificacion'];
            
            if(cotizacion.CreatedDate.addDays((integer.valueOf(configSLA.Valor_de_Comparacion__c)))>system.now()){
                NoModificable = false;
                NoFinanciable = false;
            }
            refreshUrbaninzacion();
            
            for(propiedad item:listaPropiedad){
                item.seleccionada = false;
                if(cotizacion.Implantaci_n_Principal__c == item.implan.Id){
                    propiedadSeleccionada = item;
                    propiedadSeleccionada.montoFinal = cotizacion.Monto_Base__c;
                    break;
                }
            }
            try{
                propiedadSeleccionada.seleccionada = true;
                listaPropiedad=new List<propiedad>();
                listaPropiedad.add(propiedadSeleccionada);
                urbanizacionSeleccionada = propiedadSeleccionada.implan.Lote__r.CI_Manzana__r.Etapa__c;
                
                urbanizacionSeleccionadaModelo = propiedadSeleccionada.implan.Modelo__c;
                //urbanizacionSeleccionada = propiedadSeleccionada.implan.Modelo__c;
                
                getvaluesFilterPromo();
                getvaluesFilterAdi();
                
                IngresaPreferencial = cotizacion.Ingresa_Preferencial__c;
                monto = cotizacion.Valor_Contrato__c;
                entrada = cotizacion.Valor_de_Entrada__c;
                saldo = cotizacion.Valor_Saldo__c;
                entradaPor = cotizacion.Porcentaje_Cuota_Entrada__c;
                if(entradaPor==null){entradaPor=0;}
                saldoPor = 100-entradaPor;
                plazoEntrada = cotizacion.Plazo_Cuota_Entrada__c;
                plazo = cotizacion.Plazo_Entrada_Saldo__c;
                FechaInicio = cotizacion.Fecha_Cuota_Entrada__c;
                descuento = cotizacion.Monto_Descuento__c;
                cuotaExtraEntrada = new Cuota(this);
                cuotaExtraSaldo = new Cuota(this);
                montoDescuentoMaximo = cotizacion.Valor_Saldo__c;
                descuentoPor = descuento/monto * 100;
                FechaSaldo = cotizacion.Fecha_Cuota_Saldo__c;
                cuotaExtraSaldo = new Cuota(this);
                tasaInteresSaldoCredito = cotizacion.Tasa_De_Interes_anual__c;
                montoBase = cotizacion.Monto_Base__c;
                cuotaFecha = new Cuota(this);
                CuotaFecha.Cuo.Fecha__c = fechaInicio;
                
                List<Cuota_Financiamiento__c> listaCuotasFinan = [SELECT Id, Tipo__c, Fecha__c, Valor_Presente__c, Monto_Pago__c, Orden__c, Es_Personalizado__c,
                                                                  Es_Personalizado_Eliminacion__c, Es_Personalizado_Cuota_Original__c, Monto_sin_Descuento__c, 
                                                                  Es_Personalizado_Nueva_Cuota__c
                                                                  FROM Cuota_Financiamiento__c 
                                                                  WHERE Cotizacion__c = :cotizacion.Id ORDER BY Fecha__c Desc];
                
                listaCuotasEntrada = new List<Cuota>();
                listaCuotas = new List<Cuota>();
                for(Cuota_Financiamiento__c cuota:listaCuotasFinan){
                    Cuota nueva = new Cuota(this,cuota);
                    nueva.fecha = cuota.Fecha__c;
                    nueva.cuotaAgregada = cuota.Es_Personalizado_Nueva_Cuota__c;
                    nueva.modificada = cuota.Es_Personalizado__c;
                    if(cuota.Es_Personalizado_Eliminacion__c != null && cuota.Es_Personalizado_Eliminacion__c == true){
                        nueva.cuotaAgregada = false;
                    }
                    nueva.modificada = cuota.Es_Personalizado__c;
                    
                    nueva.montoSinDescuento = cuota.Monto_sin_Descuento__c;
                    nueva.monto = cuota.Monto_Pago__c;
                    if(cuota.Tipo__c=='1'){
                        CuotaPrima = nueva;
                        CuotaPrima.Cuo = cuota; 
                        nueva.cuotaAgregada = true;
                        montoCuotaPrima = cuota.Monto_Pago__c;
                        PorcentajeCuotaPrima = cotizacion.Porcentaje_Cuota_Inicial__c;
                        PorcentajeCuotaPrima.setScale(2);
                        listaCuotasEntrada.add(nueva);
                    }else if(cuota.Tipo__c == '3'){
                        if(cuota.Monto_Pago__c==0){
                            plazoEntrada=plazoEntrada+1;
                        }
                        listaCuotasEntrada.add(nueva);
                    }else{
                        listaCuotas.add(nueva);
                    }
                }
                //ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Cuota Prima:'+cuotaPrima.cuo.Monto_Pago__c));
                calcularCoutasSaldoEntrada();
                //actualizarDescuento();
            }catch(Exception e){
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'La cotización tiene un proyecto que usted no administra.')); return;
            }
        } else {
            cotizacion.Estado__c = 'Nueva';
            try{
                oportunidad = [SELECT Id, Name, Account.Name, Account.CI_Email__c, Account.CI_Movil__c, Account.CI_Identificacion__c, Account.CI_celular__c, Fecha_de_Reserva__c,Account.CI_Tipo_Identi__c, Estado_de_Venta__c, Estado_de_Aprobacion__c, Owner.CI_Nombre_Funcion__c 
                               FROM Opportunity WHERE Id = :cotizacion.Oportunidad__c];
                // Lista de Proyectos
                listaProyectos = [SELECT ID, Name, Minimo_Reserva__c, CI_Porcentaje_Entrada__c, Maximo_de_Cuotas__c FROM Proyecto__c Where Name=:oportunidad.Owner.CI_Nombre_Funcion__c];
                opcionesProyecto = new List<SelectOption>();
                for(Proyecto__c item:listaProyectos) {
                    opcionesProyecto.add(new SelectOption(item.Id,item.Name));
                    if(item.Id==proyectoSeleccionado) { proyecto = item; ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'No hay parámetros configurados para el proyecto seleccionado, por favor contacte a su administrador.')); return;
                    }
                }
            }catch(Exception e) { ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Para ingresar una cotización nueva debe generarla desde la pantalla de una Oportunidad Activa.')); return;
            }
        }
    }
    
    public void refreshUrbaninzacion(){
        listaUrbanizaciones = [SELECT ID, Name, Proyecto__c FROM Urbanizacion__c where Proyecto__c=:proyectoSeleccionado];
        opcionesUrbanizacion = new List<SelectOption>();
        for(Urbanizacion__c item:listaUrbanizaciones) {
            opcionesUrbanizacion.add(new SelectOption(item.Id,item.Name));
        }
        getvaluesFilter();
    }
    
    public void refreshManzana(){
        listaManzanas = [SELECT ID, Name, Etapa__c FROM Manzana__c where Etapa__c=:urbanizacionSeleccionada];
        opcionesManzana = new List<SelectOption>();
        for(Manzana__c item:listaManzanas) {
            opcionesManzana.add(new SelectOption(item.Id,item.Name));
        }
    }
    
    public void refreshInmueble(){
        listaInmuebles = [SELECT ID, Name, CI_Manzana__c,CI_Fecha_Limite_Venta__c  FROM Lote__c where CI_Manzana__c=:manzanaSeleccionada order by name Asc];
        opcionesInmueble = new List<SelectOption>();
        for(Lote__c item:listaInmuebles) { opcionesInmueble.add(new SelectOption(item.Id,item.Name));
        }
    }
    
    public PageReference Guardar() {
        monto = getMontoCotizado();
        
        if(propiedadSeleccionada ==null){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Debe seleccionar una propiedad para continuar con el guardado de la cotizacion.'));
            return null;
        }
        cotizacion.Descuento_Porcentaje__c = descuentoPor;
        cotizacion.Implantaci_n_Principal__c = propiedadSeleccionada.implan.Id;
        cotizacion.Lote__c = propiedadSeleccionada.implan.Lote__c;        
        
        Financiamiento__c financiamiento = new Financiamiento__c();
        
        if(Cotizacion.Venta_Anterior__c != null) { try{ Cotizacion__c cotizacionAnterior = [SELECT ID FROM Cotizacion__c WHERE Codigo_Venta__c = :Cotizacion.Venta_Anterior__c]; }catch(Exception e) { ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Error al almacenar cotización. No existe el código de venta registrado.')); return null;
            }
        }
        
        try{
            financiamiento = [SELECT Id, Cotizacion__c FROM Financiamiento__c WHERE Id = :cotizacion.Financiamiento__c LIMIT 1];
        }catch(Exception e){
                system.debug('No existe financiamiento');
        }
             
        financiamiento.Clasificacion__c ='C';
        //financiamiento.Cuota_inicial__c = CuotaPrima.monto;
        financiamiento.Estado__c = 'P';
        //financiamiento.Fecha_cuota_inicial__c = CuotaPrima.fecha;
        financiamiento.Tipo_de_financiamiento__c = '3';
        financiamiento.Total_Dividendo__c = monto;
        financiamiento.Ajustes__c = '3';
        
        upsert financiamiento;
        
        cotizacion.Interes_Explicitos__c = 0;
        for(Cuota item:listaCuotas){
            cotizacion.Interes_Explicitos__c += item.Cuo.Interes_Saldo__c.setScale(2);
        }
        
        cotizacion.Financiamiento__c = financiamiento.Id;
        cotizacion.Precio_Lista__c = propiedadSeleccionada.getMontoTotal();
        cotizacion.Precio_Venta__c = monto;
        
        
        // ------------------- Campos de Cotizacion ----------------------------------------------------------------
        
        cotizacion.Implantaci_n_Principal__c = propiedadSeleccionada.implan.Id;
        if(cotizacion.Id==null){
            cotizacion.CI_Oportunidad_PD__c = cotizacion.Oportunidad__c;
        }
        cotizacion.Porcentaje_Cuota_Entrada__c = EntradaPor;
        cotizacion.Valor_de_Entrada__c = Entrada;
        cotizacion.Valor_Contrato__c = monto;
        cotizacion.Monto_Descuento__c = descuento;
        cotizacion.Valor_Saldo__c = saldo;
        cotizacion.Plazo_Cuota_Entrada__c = getNumeroPagosEntrada();
        cotizacion.Plazo_Entrada_Saldo__c = plazo;
        cotizacion.Fecha_Cuota_Entrada__c = FechaInicio;
        cotizacion.Fecha_Cuota_Saldo__c = fechaSaldo;
        cotizacion.Fecha_Cuota_Inicial__c = cuotaPrima.Cuo.Fecha__c;
        cotizacion.Tasa_De_Interes_anual__c = tasaInteresSaldoCredito;
        cotizacion.Monto_Base__c = propiedadSeleccionada.getMontoTotal();
        cotizacion.Porcentaje_Cuota_Inicial__c = porcentajeCuotaPrima;
        cotizacion.Valor_Cuota_Inicial_Entrada__c = cuotaPrima.monto;
        cotizacion.Tipo_Financiamiento__c = tipoFinanciamiento;
        cotizacion.Fecha_Vcto_Hipoteca__c = fechaSaldo;
        cotizacion.Valor_Presente__c = valorPresente;
        cotizacion.Valor_Contado__c = propiedadSeleccionada.getMontoTotal();
        cotizacion.CI_Proyecto__c = proyectoSeleccionado;
        cotizacion.CI_Fecha__c = system.now().date();
        cotizacion.CI_Identificacion__c = oportunidad.Account.CI_Identificacion__c;
        cotizacion.CI_Email__c = oportunidad.Account.CI_email__c;
        cotizacion.CI_Celular__c = oportunidad.Account.CI_celular__c;
        cotizacion.CI_Cuenta__c = oportunidad.AccountId;
        //cotizacion.Ingresa_Preferencial__c = IngresaPreferencial;
        cotizacion.CI_Modelo__c = propiedadSeleccionada.implan.Modelo__c;
        cotizacion.CI_Tipo_Identi__c = oportunidad.Account.CI_Tipo_Identi__c;
        cotizacion.CI_Manzana__c = propiedadSeleccionada.implan.Lote__r.CI_manzana__c;
        cotizacion.CI_Etapa__c = propiedadSeleccionada.implan.Lote__r.CI_manzana__r.Etapa__c;
        cotizacion.Valor__c = getValorAdicionales();
        cotizacion.CI_Obras_Ad__c = getValorAdicionales();
        cotizacion.CI_Dscto_Precio__c = descuento;
        cotizacion.CI_Plazo__c = 'M';
        cotizacion.CI_Cuota_Inicial__c = cuotaPrima.monto;
        cotizacion.Numero_Total_de_Cuotas__c = getNumeroPagosEntrada();
        /*If(listaCuotas != null && listaCuotas.size()>0){
            cotizacion.Fecha_de_Ultima_Cuota__c = listaCuotas[listaCuotas.size()-1].cuo.Fecha__c;
        }else{*/
            if(listaCuotasEntrada != null && listaCuotasEntrada.size()>0){
                cotizacion.Fecha_de_Ultima_Cuota__c = listaCuotasEntrada[listaCuotasEntrada.size()-1].cuo.Fecha__c; } else { cotizacion.Fecha_de_Ultima_Cuota__c = cuotaPrima.cuo.Fecha__c;
            }
        //}
        
        try{
            upsert cotizacion; }catch(Exception e){ ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Error al almacenar cotización. '+e.getMessage().split(',')[1])); return null;
        }
        PageReference direccionFin = new PageReference('/'+cotizacion.Id);
        
        List<Cuota_Financiamiento__c> cuotasInsert =new List<Cuota_Financiamiento__c>();
        List<Detalle_Promocion__c> detallesInsert = new List<Detalle_Promocion__c>();
        
        for(Cuota item: listaCuotasEntrada){
            cuotasInsert.add(item.Cuo);
            item.Cuo.tipo__c = '3';
            item.Cuo.Orden__c = item.numeroCuota;
            item.Cuo.Cotizacion__c = cotizacion.Id;
            item.Cuo.Es_Personalizado__c = item.getSeleccionar();
            item.Cuo.Es_Personalizado_Nueva_Cuota__c = item.cuotaAgregada==null?false:item.cuotaAgregada;
            item.Cuo.Es_Personalizado_Cuota_Original__c = item.modificada==null?false:item.modificada;
            if(item.modificada != null && item.modificada && item.Monto == 0){
                item.Cuo.Es_Personalizado_Eliminacion__c = true;
            }
            item.Cuo.Valor_Saldo__c = item.Cuo.Monto_Pago__c;
            item.Cuo.Valor_dividendo__c = item.Cuo.Monto_Pago__c;
            item.Cuo.Valor_Presente__c = item.valorPresente;
            item.Cuo.Financiamiento__c = financiamiento.Id;
            item.Cuo.Fecha_de_Vencimiento__c = item.Cuo.Fecha__c;
            item.Cuo.Monto_sin_Descuento__c = item.montoSinDescuento;
        }
        CuotaPrima.cuo.tipo__c = '1';
        
        for(Cuota item:listaCuotas){
            cuotasInsert.add(item.Cuo);
            item.Cuo.tipo__c = '5';
            item.Cuo.Orden__c = item.numeroCuota;
            item.Cuo.Interes_Saldo__c = item.Cuo.Interes_Saldo__c.setScale(2);
            item.Cuo.Cotizacion__c = cotizacion.Id;
            item.Cuo.Valor_Saldo__c = item.Cuo.Monto_Pago__c-item.Cuo.Interes_Saldo__c;
            item.Cuo.Valor_Presente__c = item.valorPresente;
            item.Cuo.Fecha_de_Vencimiento__c = item.Cuo.Fecha__c;
            item.Cuo.Financiamiento__c = financiamiento.Id;
            item.Cuo.Monto_sin_Descuento__c = item.montoSinDescuento;
            item.Cuo.Interes__c = item.Cuo.Interes_Saldo__c;
            item.Cuo.Valor_Interes_Explicitos__c = item.Cuo.Interes_Saldo__c.setScale(2);
        }
        
        List<Cuota_Financiamiento__c> listaRemover = [SELECT Id FROM Cuota_Financiamiento__c WHERE Cotizacion__c = :cotizacion.Id];
        delete listaRemover;
        
        List<Cuota_Financiamiento__c> listaCuotasInse = new List<Cuota_Financiamiento__c>();
        for(Cuota_Financiamiento__c item:cuotasInsert){
            if(item.Id!=null) { listaCuotasInse.add(item.clone(false,true,false,false));
            }else{
                listaCuotasInse.add(item);
            }
        }
        upsert listaCuotasInse;
        
        List<Detalle_Promocion__c> listaRemoverAdi = [SELECT Id FROM Detalle_Promocion__c WHERE Cotizacion__c = :cotizacion.Id];
        delete listaRemoverAdi;
        
        for(PromocionFeedResponse promo:listaAdicionales){
            if(promo.Seleccionar != null && promo.Seleccionar){
                Detalle_Promocion__c nuevo = new Detalle_Promocion__c(Cotizacion__c = cotizacion.Id);
                nuevo.Promocion__c = promo.promocion.Promocion__c;
                nuevo.CI_Fecha_Promo_Agre__c = system.now().date();
                nuevo.Valor_Promocion__c = promo.promocion.Valor__c;
                nuevo.Nivel__c = promo.promocion.Nivel__c;
                detallesInsert.add(nuevo);
            }
        }
        
        for(PromocionFeedResponse promo:listaPromociones){
            if(promo.Seleccionar != null && promo.Seleccionar){
                Detalle_Promocion__c nuevo = new Detalle_Promocion__c(Cotizacion__c = cotizacion.Id);
                nuevo.Promocion__c = promo.promocion.Promocion__c;
                nuevo.CI_Fecha_Promo_Agre__c = system.now().date();
                nuevo.Valor_Promocion__c = promo.promocion.Valor__c;
                detallesInsert.add(nuevo);
            }
        }
        
        for(PromocionFeedResponse promo:listaHistoricos){
            if(promo.Seleccionar != null && promo.Seleccionar){
                Detalle_Promocion__c nuevo = new Detalle_Promocion__c(Cotizacion__c = cotizacion.Id);
                nuevo.Promocion__c = promo.historial.CI_Promocion__c;
                nuevo.CI_Fecha_Promo_Agre__c = system.now().date();
                nuevo.Valor_Promocion__c = promo.historial.Valor_Promocion__c;
                detallesInsert.add(nuevo);
            }
        }
        
        insert detallesInsert;
        
        return direccionFin;
    }
    
    public void SeleccionarPropiedadLote(){
        if(Apexpages.currentPage().getParameters().get('propSele') != null){
                String idProp=Apexpages.currentPage().getParameters().get('propSele');
            for(propiedad item:listaPropiedad){
                item.seleccionada = false;
                if(idProp == item.implan.Id){
                    propiedadSeleccionada = item;
                }
            }
            if(opcionesModelo == null || opcionesModelo.size()==0) { placeOpcionesModelo(); 
            }
            
            propiedadSeleccionada.seleccionada = true;
            
            listaPropiedad=new List<propiedad>();
            listaPropiedad.add(propiedadSeleccionada);
            urbanizacionSeleccionada = propiedadSeleccionada.implan.Lote__r.CI_Manzana__r.Etapa__c;

            urbanizacionSeleccionadaModelo = propiedadSeleccionada.implan.Modelo__c;
            
            getvaluesFilterPromo();
            getvaluesFilterAdi();
            cantidadLineas = 1;
            tipoFinanciamiento = 'CD';
            iniciarFinanciamiento();
            actualizarMonto();
        }else{
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'No se encontraron Implantaciones para el lote. Consulte con su administrador.'));
            return;
        }
    }
    
    public PageReference redirectToFinanciamiento() {
        if(propiedadSeleccionada != null){
            return new PageReference('/apex/vfNewFinanciamiento?id='+cotizacion.id); } else { ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Debe seleccionar una propiedad para Financiar.')); return null;
        }    
    }
    
    List<Implantacion__c> valuesFilter;
    string queryImp; 
    
    //Método de Filtrado de Urbanizaciones y Propiedades
    public PageReference getvaluesFilter() { 
        
        queryImp = 'Select id, name, Lote__r.Name, Modelo__r.Name, Lote__r.CI_Proyecto__r.Name, Lote__r.CI_manzana__r.Name, Lote__r.CI_manzana__r.Etapa__r.Name, Lote__r.Codigo_Etapa__c, Lote__r.CI_Codigo_Inmueble__c, '+
            'Lote__r.CI_Manzana__r.Etapa__c, Precio_Lista__c,Lote__r.CI_Fecha_Limite_Venta__c, Lote__r.CI_Proyecto__r.Codigo_Proyecto__c, Lote__r.CI_Manzana__r.CI_Codigo_Manzana__c From Implantacion__c Where Activo__c = true';
        
        propiedadSeleccionada = null;
        
        //try {
        if(proyectoSeleccionado == 'false') { ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Por favor seleccione el Proyecto.')); //System.debug('Sin Proyecto');
        } else if(proyectoSeleccionado != 'false' && urbanizacionSeleccionada != 'false') { 
            String manz= '%'+manzanaSeleccionada+'%'; String mod= '%'+modeloSeleccionado+'%';
            if((urbanizacionSeleccionada == null || urbanizacionSeleccionada == '') && (manzanaSeleccionada == null || manzanaSeleccionada == '') && (modeloSeleccionado == null || modeloSeleccionado == '')){
                //System.debug(proyectoSeleccionado); System.debug(urbanizacionSeleccionada);
                queryImp += ' and Lote__r.CI_Proyecto__c = \''+proyectoSeleccionado +'\''; //System.debug(queryImp);             
            } else if((urbanizacionSeleccionada != null || urbanizacionSeleccionada != '') && (manzanaSeleccionada == null || manzanaSeleccionada == '') && (modeloSeleccionado == null || modeloSeleccionado == '')) {
                //system.debug ('proyecto: ' + proyectoSeleccionado); system.debug ('urban: ' + urbanizacionSeleccionada); 
                queryImp += ' and Lote__r.CI_Proyecto__c = \''+proyectoSeleccionado+'\' and Lote__r.CI_manzana__r.Etapa__c = \''+urbanizacionSeleccionada+'\''; //System.debug(queryImp);
                
                if(cotizacion.Id==null){
                    queryImp += ' and Lote__r.CI_Estado__c = \'D\'';
                }else{
                    queryImp += ' and Lote__c = \''+cotizacion.Implantaci_n_Principal__r.Lote__c+'\''; 
                }        
                valuesFilter = Database.query(queryImp);
                listaPropiedad = new List<Propiedad>();
                for(Implantacion__c item: valuesFilter){
                    listaPropiedad.add(new Propiedad(this, item));
                }
            } else if((urbanizacionSeleccionada != null || urbanizacionSeleccionada != '') && (manzanaSeleccionada != null || manzanaSeleccionada != '') && (modeloSeleccionado == null || modeloSeleccionado == '')) {
                queryImp += ' and Lote__r.CI_Proyecto__c = \''+proyectoSeleccionado +'\' and Lote__r.CI_manzana__r.Etapa__c = \''+urbanizacionSeleccionada+'\' and Lote__r.CI_manzana__r.Name LIKE :manz'; //System.debug(queryImp);
                if(cotizacion.Id==null){
                    queryImp += ' and Lote__r.CI_Estado__c = \'D\'';
                }else{
                    queryImp += ' and Lote__c = \''+cotizacion.Implantaci_n_Principal__r.Lote__c+'\''; 
                }        
                
                valuesFilter = Database.query(queryImp);
                listaPropiedad = new List<Propiedad>();
                for(Implantacion__c item: valuesFilter){
                    listaPropiedad.add(new Propiedad(this, item));
                }
            } else if((urbanizacionSeleccionada != null || urbanizacionSeleccionada != '') && (manzanaSeleccionada != null || manzanaSeleccionada != '') && (modeloSeleccionado != null || modeloSeleccionado != '')) {
                queryImp += ' and Lote__r.CI_Proyecto__c = \''+proyectoSeleccionado +'\' and Lote__r.CI_manzana__r.Etapa__c = \''+urbanizacionSeleccionada+'\' and Lote__r.CI_manzana__r.Name LIKE :manz and Modelo__r.Name LIKE :mod'; //System.debug(queryImp);
                if(cotizacion.Id==null){
                    queryImp += ' and Lote__r.CI_Estado__c = \'D\'';
                }else{
                    queryImp += ' and Lote__c = \''+cotizacion.Implantaci_n_Principal__r.Lote__c+'\''; 
                }        
                
                valuesFilter = Database.query(queryImp);
                listaPropiedad = new List<Propiedad>();
                for(Implantacion__c item: valuesFilter){
                    listaPropiedad.add(new Propiedad(this, item));
                }
            }else{
                queryImp += ' and Lote__r.CI_Proyecto__c = \''+proyectoSeleccionado +'\'';
            }
        } else {
            //System.debug(proyectoSeleccionado); System.debug(urbanizacionSeleccionada);
            queryImp += ' and Lote__r.CI_Proyecto__c = \''+proyectoSeleccionado +'\''; //System.debug(queryImp);  
        }
        
        if(cotizacion.Id==null){
            queryImp += ' and Lote__r.CI_Estado__c = \'D\''; } else { queryImp += ' and Lote__c = \''+cotizacion.Implantaci_n_Principal__r.Lote__c+'\''; 
        }        
        
        queryImp += ' LIMIT 500';
        
        if(proyectoSeleccionado != null && proyectoSeleccionado != 'false' && (proyecto == null || (proyecto != null && proyectoSeleccionado !=proyecto.Id))){
            proyecto = null;
            
            for(Proyecto__c item:listaProyectos) {
                if(proyectoSeleccionado!= null && proyectoSeleccionado != 'false' && item.Id==proyectoSeleccionado){
                    proyecto = item;
                }
            }
            propiedadSeleccionada = null;
            if(proyecto==null) { listaPropiedad = new List<Propiedad>(); return null;
            }
            
            
            valuesFilter = Database.query(queryImp);
            
            listaPropiedad = new List<Propiedad>();
            
            for(Implantacion__c item: valuesFilter){
                Propiedad nueva = new Propiedad(this, item);
                listaPropiedad.add(nueva);
            }
            
            placeOpcionesModelo();
        }else{
            if(proyectoSeleccionado != null && proyectoSeleccionado == 'false') { proyecto = null; listaPropiedad = new List<Propiedad>();
            }
        }
        
        return null;        
    }
    
    public PageReference Filter1() {
        getvaluesFilter();
        return null;
    }
    
    public decimal getValorAdicionales(){
        decimal total = 0;
        for(PromocionFeedResponse promo:listaAdicionales){
            if(promo.Seleccionar != null && promo.Seleccionar){
                total = total + promo.promocion.Valor__c;
            }
        }
        
        for(PromocionFeedResponse promo:listaHistoricos) { 
            if(promo.Seleccionar != null && promo.Seleccionar) { 
                total = total + promo.historial.Valor_Promocion__c;
            }
        }
        
        return total;
    } 
    
    public void placeOpcionesModelo(){
        
        List<Modelo__c> modelos = [SELECT Id, Name FROM Modelo__c WHERE CI_Proyecto__c = : proyectoSeleccionado];
        opcionesModelo = new List<SelectOption>();
        for(Modelo__c m:modelos){
            opcionesModelo.add(new SelectOption(m.Id,m.Name));
        }
    }
    
    List<Promocion_Agregada__c> valuesFilterPromo;
    //Método de Filtrado de Promociones
    public List<Promocion_Agregada__c> getvaluesFilterPromo() {
        
        if(urbanizacionSeleccionada != null){
            string query = 'Select id, name, Etapa__c, Etapa__r.Name, Promocion__c, Promocion__r.Name, Promocion__r.Estado__c, Promocion__r.Prescindible__c, Vigencia_Inicio__c, Vigencia_Fin__c, Valor__c '+
                'FROM Promocion_Agregada__c '+
                'WHERE valor__c=0 and Etapa__c=\''+urbanizacionSeleccionada+'\' and Vigencia_Inicio__c <= TODAY and Vigencia_Fin__c >= TODAY';
            valuesFilterPromo = Database.query(query);
            listaPromociones = new List<PromocionFeedResponse>();
            for(Promocion_Agregada__c item:valuesFilterPromo){
                listaPromociones.add(new PromocionFeedResponse(item));
            }
            
            If(Cotizacion.Id != null){
                List<Detalle_Promocion__c> listaDetallesPromocion = [SELECT Id, Promocion__c FROM Detalle_Promocion__c WHERE Cotizacion__c = :Cotizacion.Id];
                for(Detalle_Promocion__c detalle:listaDetallesPromocion){
                    for(PromocionFeedResponse item:listaPromociones){
                        if(detalle.Promocion__c == item.promocion.Promocion__c){
                            item.seleccionar = true;
                        }
                    }
                }
            }
            
            List<Historial_Promocion__c> listaHistorico = [SELECT Id,Name,Valor_Promocion__c,CI_Promocion__r.Name,CI_Promocion__r.Prescindible__c, CI_Promocion__c FROM Historial_Promocion__c 
                                                       WHERE Codigo_Etapa__c = :propiedadSeleccionada.implan.Lote__r.Codigo_Etapa__c 
                                                        and Codigo_Manzana__c = :propiedadSeleccionada.implan.Lote__r.CI_Manzana__r.CI_Codigo_Manzana__c
                                                        and Codigo_Proyecto__c = :propiedadSeleccionada.implan.Lote__r.CI_Proyecto__r.Codigo_Proyecto__c
                                                        and Codigo_Solar__c = :propiedadSeleccionada.implan.Lote__r.CI_Codigo_Inmueble__c];
        
            for(Historial_Promocion__c promo:listaHistorico){
                //listaHistoricos.add(new PromocionFeedResponse(promo));
                integer index=-1;
                for(integer i = 0;i<listaPromociones.size();i++){
                    if(listaPromociones[i].promocion.promocion__c == promo.CI_Promocion__c && !promo.CI_Promocion__r.Prescindible__c){
                        index=i;
                        break;
                    }
                }
                if(index!=-1){
                    listaPromociones.remove(index);
                }
            }
            
            return valuesFilterPromo;
        }
        return null;
    }
    
    public boolean getesVendedor(){
        if(usuario.profile.Name.contains('Asesor')) { return true;
        }
        return false;
    }
    
    public boolean getTieneHistorico(){
        if(listaHistoricos != null && listaHistoricos.size()>0){ return true;
        }
        return false;
    }
    
    List<Promocion_Agregada__c> valuesFilterAdi;
    //Método de Filtrado de Promociones
    public List<Promocion_Agregada__c> getvaluesFilterAdi() {
        
        string query = 'Select id, name, Etapa__c, Modelo__c, Nivel__c, Etapa__r.Name, Etapa__r.Codigo_Empresa__c, Promocion__c, Promocion__r.Nivel__c, Promocion__r.Name, Promocion__r.Estado__c, promocion__r.Codigo__c, Promocion__r.Prescindible__c, Vigencia_Inicio__c, Vigencia_Fin__c, Valor__c '+
            'FROM Promocion_Agregada__c '+
            'WHERE valor__c!=0 and Etapa__c=\''+urbanizacionSeleccionada+'\' and Vigencia_Inicio__c <= TODAY and Vigencia_Fin__c >= TODAY ORDER BY Promocion__r.Name';
               
        List<string> listaPromocionIds = new List<string>();
        List<string> listaEtapasCodigos = new List<string>();
        valuesFilterAdi = Database.query(query);
        System.debug('Query: '+valuesFilterAdi);
        listaAdicionales = new List<PromocionFeedResponse>();
        
        set<Id> idValues = new set<Id>();
        set<String> idValues2 = new set<String>();
        Set<String> empresas = new Set<String>();
        for(Promocion_Agregada__c item : valuesFilterAdi) {
            idValues.add(item.Modelo__c);
            idValues2.add(item.Nivel__c);
            empresas.add(item.Etapa__r.Codigo_Empresa__c);
        }
        System.debug('Promociones agregadas idValues2: '+idValues2);
        System.debug('Promociones agregadas Empresas: '+empresas);
        List<Detalle_Promocion_por_Modelo__c> listdetProMod = new List<Detalle_Promocion_por_Modelo__c>();
        listdetProMod = [Select Id, Modelo__c, Nivel__c from Detalle_Promocion_por_Modelo__c Where Modelo__c =: urbanizacionSeleccionadaModelo and Nivel__c In : idValues2 and Empresa__c In : empresas];
        system.debug('listdetProMod: '+listdetProMod);
        
        for(Promocion_Agregada__c item : valuesFilterAdi) {
            if(listdetProMod.size() > 0) {
                if(item.Promocion__r.Nivel__c == false) {
                    System.System.debug('Check False: '+item.promocion__c);
                    listaAdicionales.add(new PromocionFeedResponse(item));
                }
                System.System.debug('Encontramos detalles de promoción por modelo');
                for(Detalle_Promocion_por_Modelo__c detPromoMod : listdetProMod) {
                    System.debug('Valores a comparar: '+detPromoMod.Id+'---'+detPromoMod.Modelo__c+'--'+item.Modelo__c+'---'+detPromoMod.Nivel__c+'---'+item.Nivel__c);
                    if(item.Promocion__r.Nivel__c == true && detPromoMod.Modelo__c == item.Modelo__c && detPromoMod.Nivel__c == item.Nivel__c){                      
                        listaAdicionales.add(new PromocionFeedResponse(item));
                    }
                } 
            } else {
                System.debug('No encontamos detalles de promoción por modelo');
                if(item.Promocion__r.Nivel__c == false) {
            		listaAdicionales.add(new PromocionFeedResponse(item));
                }
            }
            listaPromocionIds.add(''+item.promocion__r.Codigo__c);
        }

        System.debug('Todos los registros: '+listaAdicionales);
        System.debug('Todos los registros: '+listaAdicionales.size());
        
        If(Cotizacion.Id != null){
            List<Detalle_Promocion__c> listaDetallesPromocion = [SELECT Id, Promocion__c FROM Detalle_Promocion__c WHERE Cotizacion__c = :Cotizacion.Id];
            for(Detalle_Promocion__c detalle:listaDetallesPromocion){
                for(PromocionFeedResponse item:listaAdicionales){
                    if(detalle.Promocion__c == item.promocion.Promocion__c){
                        item.seleccionar = true;
                    }
                }
            }
        }
        
        List<Historial_Promocion__c> listaHistorico = [SELECT Id,Name,Valor_Promocion__c,Nivel__c,CI_Promocion__r.Name,CI_Promocion__r.Prescindible__c, CI_Promocion__c FROM Historial_Promocion__c 
                                                       WHERE Codigo_Etapa__c = :propiedadSeleccionada.implan.Lote__r.Codigo_Etapa__c 
                                                        and Codigo_Manzana__c = :propiedadSeleccionada.implan.Lote__r.CI_Manzana__r.CI_Codigo_Manzana__c
                                                        and Codigo_Proyecto__c = :propiedadSeleccionada.implan.Lote__r.CI_Proyecto__r.Codigo_Proyecto__c
                                                        and Codigo_Solar__c = :propiedadSeleccionada.implan.Lote__r.CI_Codigo_Inmueble__c];
        
        
        listaHistoricos = new List<PromocionFeedResponse>();
                       
        for(Historial_Promocion__c promo:listaHistorico){
            listaHistoricos.add(new PromocionFeedResponse(promo));
            integer index=-1;
            for(integer i = 0;i<listaAdicionales.size();i++){
                if(listaAdicionales[i].promocion.promocion__c == promo.CI_Promocion__c && !promo.CI_Promocion__r.Prescindible__c){
                    index=i;
                    break;
                }
            }
            if(index!=-1){
                listaAdicionales.remove(index);
            }
        }
        
        If(Cotizacion.Id != null){
            List<Detalle_Promocion__c> listaDetallesPromocion = [SELECT Id, Promocion__c FROM Detalle_Promocion__c WHERE Cotizacion__c = :Cotizacion.Id];
            for(PromocionFeedResponse item:listaHistoricos){
                boolean encontrado = false;
                for(Detalle_Promocion__c detalle:listaDetallesPromocion){
                    if(detalle.Promocion__c == item.historial.CI_Promocion__c){
                        encontrado = true;
                    }
                }
                if(!encontrado){
                    item.seleccionar = false;
                }
            }
        }
        
        return valuesFilterAdi;
    }
    
    public class propiedad{
        public extensionCotizacion controller {get;set;}
        public boolean seleccionada {get;set;}
        public Lote__c lote {get;set;}
        public Lote__c parqueo {get;set;}        
        public Implantacion__c implan {get;set;}
        List<Implantacion__c> listaImpantacion {get;set;}
        public string modeloSeleccionado {get;set;}
        public decimal montoFinal {get;set;}
        
        public propiedad(extensionCotizacion cont, Implantacion__c lot){
            controller = cont;
            implan = lot;
            modeloSeleccionado = implan.Modelo__c;
            listaImpantacion = new List<Implantacion__c>();
            montoFinal = implan.Precio_Lista__c;
        }
        
        public decimal getMontoTotal(){
            if(implan  != null){
                return montoFinal; } return lote.CI_Precio_Actual__c;
        }
                
        public void changeModelo(){
            if(modeloSeleccionado != implan.Modelo__c){
                List<Implantacion__c> lista = [SELECT id, name, Lote__r.Name, Modelo__r.Name, Lote__r.CI_Proyecto__r.Name, Lote__r.CI_manzana__r.Name, Lote__r.CI_manzana__r.Etapa__r.Name, 
                                                   Lote__r.Codigo_Etapa__c, Lote__r.CI_Codigo_Inmueble__c, Lote__r.CI_Manzana__r.Etapa__c, Precio_Lista__c,Lote__r.CI_Fecha_Limite_Venta__c, 
                                                   Lote__r.CI_Proyecto__r.Codigo_Proyecto__c, Lote__r.CI_Manzana__r.CI_Codigo_Manzana__c 
                                               FROM Implantacion__c 
                                               WHERE Lote__c =:implan.Lote__c and Modelo__c =:modeloSeleccionado];
                
                if(lista.size()>0) { implan = lista[0];
                }else{
                    Implantacion__c nuevaImplan = new Implantacion__c(Name = 'Implantación', Lote__c = implan.Lote__c, Modelo__c = modeloSeleccionado, Precio_Lista__c=implan.Precio_Lista__c, activo__c=true);
                    
                    insert nuevaImplan;
                    List<Implantacion__c> listaNueva = [SELECT id, name, Lote__r.Name, Modelo__r.Name, Lote__r.CI_Proyecto__r.Name, Lote__r.CI_manzana__r.Name, Lote__r.CI_manzana__r.Etapa__r.Name, 
                                                   Lote__r.Codigo_Etapa__c, Lote__r.CI_Codigo_Inmueble__c, Lote__r.CI_Manzana__r.Etapa__c, Precio_Lista__c,Lote__r.CI_Fecha_Limite_Venta__c, 
                                                   Lote__r.CI_Proyecto__r.Codigo_Proyecto__c, Lote__r.CI_Manzana__r.CI_Codigo_Manzana__c 
                                               FROM Implantacion__c 
                                               WHERE Lote__c =:implan.Lote__c and Modelo__c =:modeloSeleccionado];
                    
                    implan = listaNueva[0];
                }
            }
        }
    }     
    
    public class PromocionFeedResponse{
        public Promocion_Agregada__c promocion {get;set;}
        public Historial_Promocion__c historial {get;set;}
        
        public boolean seleccionar {get;Set;}
        
        public PromocionFeedResponse(Promocion_Agregada__c a){
            promocion = a;
            Seleccionar = false;
            historial = new Historial_Promocion__c();
        }
        
        public PromocionFeedResponse(Historial_Promocion__c a){
            Seleccionar = true;
            historial = a;
        }
    }
    
    //--------------------------------------------------------------------------------------------------------------------------------
    //                                                  Sección Financiamiento
    //--------------------------------------------------------------------------------------------------------------------------------
    
    
    public decimal monto {get;set;}
    public decimal montoReserva {get;set;}
    public decimal ROI {get;set;}
    public decimal montoBase {get;set;}
    public decimal Entrada {get;set;}
    public decimal EntradaPor {get;set;}
    public decimal Saldo {get;set;}
    public decimal SaldoPor {get;set;}
    public date FechaInicio {get;set;}
    public decimal plazo {get;set;}
    public decimal plazoEntrada {get;set;}
    public List<Cuota> listaCuotas {get;set;}
    public List<Cuota> listaCuotasEntrada {get;set;}
    public List<Cuota> listaCuotasEntradaVisible {get;set;}
    public date FechaSaldo {get;set;}
    public Cuota cuotaExtraEntrada {get;set;}
    public Cuota cuotaExtraSaldo {get;set;}
    public string tipoFinanciamiento {get;set;}
    public Decimal descuento {get;set;}
    public Decimal descuentoPor {get;set;}
    public Cuota CuotaPrima {get;set;}
    public Cuota CuotaFecha {get;set;}  
    public decimal porcentajeCuotaPrima {get;set;}
    public decimal montoCuotaPrima {get;set;}
    public decimal tasaInteresSaldoCredito {get;set;}
    public integer cuotaEliminar {get;set;}
    public decimal descuentoMaximo {get;set;}
    public decimal descuentoMaximoPor {get;set;}
    public decimal descuentoTabla {get;set;}
    public boolean permiteSalirRef {get;set;}
    
    public List<Cuota> planCuotasOrdinario {get;set;}
    
    public void iniciarFinanciamiento(){
        if(descuento==null){ 
            descuento = 0;
        }
        
        monto = propiedadSeleccionada.getMontoTotal() + getValorAdicionales() - descuento;
        ROI = 16;
        
        montoBase = monto.setScale(2);
        EntradaPor = 30;
        
        Entrada = monto * EntradaPor/100;
        Entrada = Entrada.setScale(2);
        SaldoPor = 100-EntradaPor;
        Saldo = monto * SaldoPor/100;
        Saldo = Saldo.setScale(2);
        plazoEntrada = 10;
        plazo = 12;
        listaCuotas = new List<Cuota>();
        listaCuotasEntrada = new List<Cuota>();
        FechaInicio = system.now().date().addMonths(1);
        
        tasaInteresSaldoCredito = 11.33;
        porcentajeCuotaPrima = 15;
        descuento = 0;
        descuentoPor = 0;
        
        CuotaFecha = new Cuota(this);
        CuotaFecha.Cuo.Fecha__c = FechaInicio;
        
        CuotaPrima = new Cuota(this);
        CuotaPrima.fecha = system.now().date();
        CuotaPrima.numeroCuota = 0;
        CuotaPrima.Monto = monto*porcentajeCuotaPrima/100;
        CuotaPrima.Monto = CuotaPrima.Monto.setScale(2);
        CuotaPrima.MontoSinDescuento = CuotaPrima.Monto;
        montoCuotaPrima = CuotaPrima.Monto;
        CuotaPrima.Cuo.Fecha__c = CuotaPrima.fecha;
        CuotaPrima.Cuo.Monto_Pago__c = monto*porcentajeCuotaPrima/100;
        CuotaPrima.Cuo.Monto_Pago__c = CuotaPrima.Cuo.Monto_Pago__c.setScale(2);
        CuotaPrima.cuotaAgregada = true;
        listaCuotasEntrada.add(CuotaPrima);
        
        cuotaExtraEntrada = new Cuota(this);
        cuotaExtraSaldo = new Cuota(this);
        
        montoDescuentoMaximo = saldo;
        changeFinanciamiento();
        
        calcularCoutasSaldoEntrada();
        
    }
        
    public void actualizarDescuentoPor(){
        if(descuentoPor<=99){ 
        } else { 
            descuentoPor = 0; 
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'El descuento no puede ser mayor al monto total de venta.'));
        }
        descuento = (propiedadSeleccionada.getMontoTotal() + getValorAdicionales())*descuentoPor/100;
        descuento = descuento.setScale(2);
        descuentoMaximo =  propiedadSeleccionada.getMontoTotal() + getValorAdicionales() -descuento;
        actualizarMonto();
    }
    
    public void RecalcularCuotas(){
        fechaInicio = CuotaFecha.Cuo.Fecha__c;
        calcularCoutasSaldoEntrada();
        calcularCoutasSaldo();
    }
    
    public void recalcularMontoCuotaPrima(){
        if(montoCuotaPrima>0 || cotizacion.CI_Tipo_Venta__c == '4'){
            porcentajeCuotaPrima = montoCuotaPrima*100/monto;
            porcentajeCuotaPrima = porcentajeCuotaPrima.setScale(2);
            CuotaPrima.Monto = montoCuotaPrima;
            CuotaPrima.MontoSinDescuento = montoCuotaPrima;
            CuotaPrima.Cuo.Monto_Pago__c = CuotaPrima.monto;
            calcularCoutasSaldoEntrada(); 
        } else { 
            montoCuotaPrima = monto*porcentajeCuotaPrima/100; 
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'No puede cambiar el valor de el primer pago a menor a 0.')); 
            return;
        }
    }
    
    public void recalcularPorcentajeCuotaPrima(){
        CuotaPrima.Monto = monto*porcentajeCuotaPrima/100;
        CuotaPrima.Monto = CuotaPrima.Monto.setScale(2);
        montoCuotaPrima = CuotaPrima.Monto;
        CuotaPrima.Cuo.Monto_Pago__c = CuotaPrima.monto;
        CuotaPrima.MontoSinDescuento = CuotaPrima.monto;
        calcularCoutasSaldoEntrada();
        calcularCoutasSaldo();
    }
    
    public decimal getMontoCotizado(){
        if(descuento == null){
            descuento = 0;
        }
        if(propiedadSeleccionada != null){
                return propiedadSeleccionada.getMontoTotal() + getValorAdicionales() - descuento;
        }else{
            return 0;
        }
    }
    
    public void actualizarMonto(){
        try{
        monto = propiedadSeleccionada.getMontoTotal() + getValorAdicionales() - descuento;
        recalcularPorcentajeEntrada();
        CuotaPrima.Monto = monto * porcentajeCuotaPrima/100;
        CuotaPrima.Monto = CuotaPrima.Monto.setScale(2);
        CuotaPrima.MontoSinDescuento = CuotaPrima.Monto;
        CuotaPrima.Cuo.Monto_Pago__c = CuotaPrima.Monto;
        montoCuotaPrima = CuotaPrima.Monto;
        cuotaPrima.monto = cuotaPrima.Cuo.Monto_Pago__c;
        cuotaPrima.montoSinDescuento = cuotaPrima.Cuo.Monto_Pago__c;
        montoCuotaPrima = cuotaPrima.monto;
        descuentoMaximo = 0;
        
        if(descuentoMaximoPor == null){
            descuentoMaximoPor = 0;
        }
        if(valorPresente == null){
            valorPresente = 0;
        }
        
        descuentoMaximo = (valorPresente-montoBase)*(descuentoMaximoPor/100);
        descuentoMaximo = descuentoMaximo.setScale(2);
        
        recalcularValorEntrada(); }catch(Exception e){
            
        }
    }
    
    public void recalcularDescuentoPor(){
        if(descuento == null){ descuento = 0;
        }
        decimal diferencial = 0;
        if(montoDescuentoMaximo != null && montoDescuentoMaximo != 0){
            diferencial = ((descuento/(propiedadSeleccionada.getMontoTotal() + getValorAdicionales())))*100;
            diferencial = diferencial.setScale(2);
        }
        if(diferencial!=0){ descuentoPor = diferencial; descuentoPor = descuentoPor.setScale(2);
        }else{
            descuentoPor = 0;
        }
    }
    
    public void recalcularAlertaDescuento(){
        
    }
    
    public void actualizaPrecioLista(){
        
    }
        
    public void changeFinanciamiento(){
        if(propiedadSeleccionada == null) { return;
        }
        
        if(Cotizacion.CI_Tipo_Venta__c == '1'){
            
            EntradaPor = 30;
            Entrada = monto * EntradaPor/100;
            SaldoPor = 0;
            Saldo = monto * SaldoPor/100;
            plazo = 0;
            
            plazo = 1;
            tasaInteresSaldoCredito = 0;
            
        }else{
            
        }
    }
    
    public void recalcularValorEntrada(){
        
        EntradaPor = entrada*100/monto;
        EntradaPor = EntradaPor.setScale(2);
        SaldoPor = 100-EntradaPor;
        Saldo = monto*SaldoPor/100;
        Saldo = Saldo.setScale(2);
        
                
        calcularCoutasSaldoEntrada();
        calcularCoutasSaldo();
    }
    
    public void recalcularPorcentajeEntrada(){
                
        Entrada = monto*entradaPor/100;
        Entrada = Entrada.setScale(2);
        Saldo = monto-Entrada;
        calcularCoutasSaldoEntrada();
        calcularCoutasSaldo();
    }
    
    public void AgregarCuotaEntrada(){
        if(cuotaExtraEntrada != null && cuotaExtraEntrada.Cuo != null && cuotaExtraEntrada.Cuo.Fecha__c == null){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Debe ingresar una fecha de pago'));
            return;
        }
        if(cuotaExtraEntrada.Cuo.Fecha__c < system.now().date()){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'La fecha de el primer pago no puede ser menor a hoy.'));
            return;
        }else if(cuotaExtraEntrada.Cuo.Fecha__c >= FechaSaldo){ ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'La fecha de el pago de entrada no puede ser despues de el inicio de el financiamiento.')); return;
        }
        
        cuotaExtraEntrada.numeroCuota = 0;
        cuotaExtraEntrada.Monto = cuotaExtraEntrada.Cuo.Monto_Pago__c;
        cuotaExtraEntrada.cuotaAgregada = true;
        cuotaExtraEntrada.fecha = cuotaExtraEntrada.Cuo.Fecha__c;
        cuotaExtraEntrada.MontoSinDescuento = cuotaExtraEntrada.Monto;
        listaCuotasEntrada.add(cuotaExtraEntrada);
        
        calcularCoutasSaldoEntrada();
        cuotaExtraEntrada = new Cuota(this);
    }
    
    public integer getNumeroPagosEntrada(){
        if(listaCuotasEntradaVisible != null){
            return listaCuotasEntradaVisible.size()-1; } else { return 0;
        }
    }
    
    public void setNumeroPagosEntrada(integer newValue){
        if(plazoEntrada != null){
            integer diferencia = getNumeroPagosEntrada() - newValue;
            plazoEntrada -= diferencia;
        }
    }
    
    public PageReference redirectFromFinanciamiento(){
        
        validateSLA();
        
        permiteSalirRef = true;
        
        if(permiteSalirRef){
            return new PageReference('/apex/vfCotizacionNew'); } else { return null;
        }
    }
    
    //---------------------------------------------------------------------------------------------------------------------------
    //                                                  Generación de Cuotas
    //---------------------------------------------------------------------------------------------------------------------------
    
    public void validateSLA() {        
        //----- Inicio Código 31/01/2020 -----
        try {
            List<Proyecto__c> listaProyectos2 = [SELECT ID, Name, Minimo_Reserva__c, CI_Porcentaje_Entrada__c, Maximo_de_Cuotas__c FROM Proyecto__c 
                                                 Where Name=:oportunidad.Owner.CI_Nombre_Funcion__c];
            System.debug('Proyecto Contización ' + listaProyectos2[0].Name);
            
            Decimal porcentajeProyecto = 0.00;
            Integer tiempoPagoReserva = 0;
            if(listaProyectos2[0].Name == 'LA RIOJA') {
                Sales_SLA_config__mdt configSLA2 = [SELECT MasterLabel, Valor_de_Comparacion__c FROM Sales_SLA_config__mdt WHERE QualifiedApiName='SG7'];
                porcentajeProyecto = Decimal.valueOf(configSLA2.Valor_de_Comparacion__c);
                    
                Sales_SLA_config__mdt configSLA3 = [SELECT MasterLabel, Valor_de_Comparacion__c FROM Sales_SLA_config__mdt WHERE QualifiedApiName='RG9'];
                tiempoPagoReserva = (Integer.valueOf(configSLA3.Valor_de_Comparacion__c)-1); 
            } else if(listaProyectos2[0].Name == 'LA GRAN VITTORIA') { 
                Sales_SLA_config__mdt configSLA4 = [SELECT MasterLabel, Valor_de_Comparacion__c FROM Sales_SLA_config__mdt WHERE QualifiedApiName='SG6']; 
                porcentajeProyecto = Decimal.valueOf(configSLA4.Valor_de_Comparacion__c); 
                Sales_SLA_config__mdt configSLA5 = [SELECT MasterLabel, Valor_de_Comparacion__c FROM Sales_SLA_config__mdt WHERE QualifiedApiName='RG8']; 
                tiempoPagoReserva = (Integer.valueOf(configSLA5.Valor_de_Comparacion__c)-1);
            } 
            System.Debug('Tiempo de reserva: ' + tiempoPagoReserva);
                
            monto = getMontoCotizado(); 
            System.Debug('monto cotizado '+monto);
            montoReserva = monto*(porcentajeProyecto/100); 
            System.Debug('monto reserva '+montoReserva.setScale(2));
            //integer tiempoPagoReserva = cuotasRioja;
            Decimal cuotaPagoReserva = 0.00;        
            for(Integer i = 0; i <= tiempoPagoReserva; i++) {
                cuotaPagoReserva += listaCuotasEntradaVisible[i].Cuo.Monto_Pago__c;           
            } 
            System.Debug('listaCuotasEntrada: '+cuotaPagoReserva);
                
            if(montoReserva.setScale(2) > cuotaPagoReserva.setScale(2)) { 
                System.debug('El porcentaje mínimo de reserva no se cubre en las cuotas de pago iniciales'); 
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'El porcentaje mínimo de reserva no se cubre en las cuotas de pago iniciales')); 
                return;
            }             
        } catch(Exception e) {
        }
        //----- Fin Código 31/01/2020 -----               
    }
    
    public void calcularCoutasSaldoEntrada(){
        List<Cuota> cuotasAgregadas = new List<Cuota>();
        List<Cuota> cuotasModificadas = new List<Cuota>();
        decimal valorAgregado = 0;
        integer cuotasMod = 0;
        integer cuotasElim = 0;
        decimal entradaSinDescuento = 0;
        if(cotizacion.ID==null){
            entradaSinDescuento = (monto+descuento)*EntradaPor/100;
            //entradaSinDescuento = (monto)*EntradaPor/100;
        }else{
            entradaSinDescuento = (monto+descuento)*EntradaPor/100;
        }
        decimal sumaFinal = 0;
        decimal sumaCuotasEliminadas = 0;
        entradaSinDescuento = entradaSinDescuento.setScale(2);
        for(Cuota item:listaCuotasEntrada){
            boolean notdouble=true;
            if(item.cuotaAgregada != null && item.cuotaAgregada){
                cuotasAgregadas.add(item);
                cuotasElim = cuotasElim+1;
                valorAgregado = valorAgregado + item.Cuo.Monto_Pago__c;
                sumaFinal+=item.Monto;
                notdouble= false;
            }
            if(item.modificada != null && item.modificada && notdouble){
                cuotasAgregadas.add(item);    
                if(item.Cuo.Monto_Pago__c == null) { 
                    item.Cuo.Monto_Pago__c = 0; 
                }            
                valorAgregado = valorAgregado + item.Cuo.Monto_Pago__c;
                cuotasMod = cuotasMod+1;
                if(item.Monto == null) { 
                    item.Monto = 0; 
                }
                sumaFinal+=item.Monto;
                cuotasModificadas.add(item);
            }
        }
        
        if(valorAgregado > Entrada && EntradaPor != porcentajeCuotaPrima){ 
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,' El valor de las Cuotas Fijas es mayor que el monto de Entrada, Suma de Cuotas Fijas: '+valorAgregado)); 
            return;
        }else if(EntradaPor == porcentajeCuotaPrima){ 
            valorAgregado = Entrada; 
            cuotaPrima.Monto = Entrada; 
            cuotaPrima.Cuo.Monto_Pago__c = Entrada; 
            CuotaPrima.montoSinDescuento = entradaSinDescuento; 
            montoCuotaPrima = Entrada; 
            plazoEntrada = 1;
        }
        
        listaCuotasEntrada = new List<Cuota>();
        integer cuotasExtra = 0;
        integer valorResta = 1;
        if(cuotasElim >0 && cotizacion.Id!=null){ 
            valorResta = cuotasElim;
        }
        //ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,' Valor plazoEntrada: '+ plazoEntrada + ' Cuotas: '+(plazoEntrada-cuotasMod)));
        
        for(Integer i =0;i<=plazoEntrada-valorResta;i++){
            boolean bandera = true;
            Cuota item;
            
            for(Cuota item2 :cuotasModificadas){
                if(FechaInicio.addMonths(i).month() == item2.fecha.month() && FechaInicio.addMonths(i).year() == item2.fecha.year()){
                    bandera = false;
                    item = item2;
                    break;
                }
            }
            
            if(bandera){
                item = new Cuota(this);
                
                if(FechaInicio.month() != FechaInicio.addDays(1).month() && FechaInicio.addMonths(i).month()==FechaInicio.addMonths(i).addDays(1).month()){ 
                    item.fecha = FechaInicio.addMonths(i).addDays(1);                
                }else{
                    item.fecha = FechaInicio.addMonths(i);                
                }
                
                item.numeroCuota = i;
                if(plazoEntrada-cuotasMod <= 0){ 
                    item.monto=0;
                }else{
                    if(cotizacion.Id!=null) { 
                        item.Monto = (Entrada - valorAgregado)/(plazoEntrada-cuotasMod - cuotasElim +1);
                    }else{
                        item.Monto = (Entrada - valorAgregado)/(plazoEntrada-cuotasMod);
                    }
                }
                item.Monto = item.Monto.setScale(2);
                if(cotizacion.Id != null){ 
                    if(plazoEntrada-cuotasMod <=0){ 
                        item.montoSinDescuento = 0; 
                    } else{ 
                        if(cotizacion.Id!=null){ 
                            item.montoSinDescuento = (entradaSinDescuento - valorAgregado)/(plazoEntrada-cuotasMod - cuotasElim +1); 
                        }else{ 
                            item.montoSinDescuento = (entradaSinDescuento - valorAgregado)/(plazoEntrada-cuotasMod);
                        }
                        //item.montoSinDescuento = (entradaSinDescuento - valorAgregado)/(plazoEntrada-cuotasMod);
                    }
                    item.montoSinDescuento = item.montoSinDescuento.setScale(2);
                }else{
                    item.montoSinDescuento = (entradaSinDescuento - valorAgregado)/(plazoEntrada-cuotasMod);
                    item.montoSinDescuento = item.montoSinDescuento.setScale(2);
                }
                item.Cuo.Fecha__c = item.fecha;
                item.Cuo.Monto_Pago__c = item.Monto;
                
                if((sumaFinal+item.Monto)<=Entrada+1 || Cotizacion.Id==null){
                    //ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,' valor SumaFinal: '+sumaFinal));
                    sumaFinal +=item.Monto;
                    listaCuotasEntrada.add(item);
                }else{
                    break;
                }
            }
            
            integer mesesAgregar = 1;
            
            fechaSaldo = item.fecha.addMonths(Integer.valueOf(plazoEntrada +mesesAgregar));
            
            cuotaExtraSaldo.Cuo.Fecha__c = FechaSaldo;
        }
        for(Cuota item:cuotasAgregadas){
            listaCuotasEntrada.add(item);
            System.debug('listaCuotasEntrada: '+item);
        }
        listaCuotasEntrada.sort();
        listaCuotasEntradaVisible = new List<Cuota>();
        for(integer i = 0;i<listaCuotasEntrada.size();i++){
            if(listaCuotasEntrada[i].Monto!=0 || i==0){
                listaCuotasEntrada[i].numeroCuota = i;
                listaCuotasEntradaVisible.add(listaCuotasEntrada[i]);
            }else{
                listaCuotasEntrada[i].numeroCuota = -1;
            }
        }
        for(integer i = 0;i<listaCuotasEntradaVisible.size();i++){
            listaCuotasEntradaVisible[i].numeroCuota = i;
        }
        try{
            if(getTotalMontoSaldoEntrada() != Entrada){
                listaCuotasEntradaVisible[listaCuotasEntradaVisible.size()-1].Monto -= (getTotalMontoSaldoEntrada()-Entrada);
                listaCuotasEntradaVisible[listaCuotasEntradaVisible.size()-1].Cuo.Monto_Pago__c = listaCuotasEntradaVisible[listaCuotasEntradaVisible.size()-1].Monto;
                listaCuotasEntradaVisible[listaCuotasEntradaVisible.size()-1].MontoSinDescuento = listaCuotasEntradaVisible[listaCuotasEntradaVisible.size()-1].Monto;
            } 
        } catch(Exception e) { 
            Entrada = getTotalMontoSaldoEntrada();
        }
        if(tipoFinanciamiento == 'CD'){
            fechaSaldo = null;
        }
        calcularCoutasSaldo();
        validateSLA();
    }
        
    public void recalcularValorSaldo(){
        SaldoPor = Saldo*100/monto;
        SaldoPor = SaldoPor.setScale(2);
        EntradaPor = 100-SaldoPor;
        Entrada = monto*EntradaPor/100;
        Entrada = Entrada.setScale(2);
        calcularCoutasSaldo();
        calcularCoutasSaldoEntrada();
    }
    
    public void recalcularPorcentajeSaldo(){
        Saldo = monto * SaldoPor/100;
        Saldo = Saldo.setScale(2);
        EntradaPor = 100-SaldoPor;
        Entrada = monto*EntradaPor/100;
        Entrada = Entrada.setScale(2);
        calcularCoutasSaldo();
        calcularCoutasSaldoEntrada();
    }
    
    public void modificarFechaSaldo(){
        if(cuotaExtraSaldo.Cuo.Fecha__c >= FechaSaldo){
            FechaSaldo = cuotaExtraSaldo.Cuo.Fecha__c;
            calcularCoutasSaldo(); } else{ ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'La fecha de el primer pago no puede ser menor')); return;
        }
    }
    
    public decimal getValorCotizacion(){
        return monto;
    }
    
    public void changeInstitucionFinanciera(){
        
    }
    
    public void calcularCoutasSaldo(){
        listaCuotas = new List<Cuota>();
        if(EntradaPor == 100){ 
            plazo = 0;
        }
        
        //decimal tasa = 11.3;
        decimal saldoSinDescuento = (monto+descuento)*SaldoPor/100;
        saldoSinDescuento = saldoSinDescuento.setScale(2);
        try{
            if(listaCuotasEntradaVisible.size()> 0 && (fechaSaldo == null || tipoFinanciamiento == 'CD')){
                fechaSaldo = listaCuotasEntradaVisible[listaCuotasEntradaVisible.size()-1].Cuo.Fecha__c.addMonths(Integer.valueOf(1));
            }else{ 
                FechaSaldo = listaCuotasEntradaVisible[listaCuotasEntradaVisible.size()-1].Cuo.Fecha__c.addMonths(Integer.valueOf(1)); 
            } 
        }catch(Exception e){ 
            fechaSaldo = system.now().date();
        }
        saldo = monto-entrada;
        decimal capital = saldo;
        decimal tasaMen = tasaInteresSaldoCredito/1200;
        
        for(Integer i=1;i<=plazo;i++){
            Cuota item = new Cuota(this);
            item.fecha = FechaSaldo.addMonths(i-1);
            item.numeroCuota = i;
            //item.Monto = saldo*(1+tasaInteresSaldoCredito/1200)/plazo;
            decimal val1 = 1/((1+tasaInteresSaldoCredito/1200).pow(Integer.valueOf(plazo)));
            decimal val2 = 1-val1;
            if(val2 !=0){
                if(cotizacion.Id!=null){ 
                    item.monto = (saldo*tasaInteresSaldoCredito/1200)/val2; 
                    item.MontoSinDescuento = (saldoSinDescuento*tasaInteresSaldoCredito/1200)/val2; 
                    item.Cuo.Interes_Saldo__c = capital*tasaMen; 
                    capital-=item.monto- item.Cuo.Interes_Saldo__c;
                }else{
                    item.monto = (saldo*tasaInteresSaldoCredito/1200)/val2;
                    item.MontoSinDescuento = (saldoSinDescuento*tasaInteresSaldoCredito/1200)/val2;
                    item.Cuo.Interes_Saldo__c = capital*tasaMen;
                    capital-=item.monto- item.Cuo.Interes_Saldo__c;
                }
            }else{
                if(cotizacion.Id!=null){
                    item.monto = saldo*(1+tasaInteresSaldoCredito/1200)/plazo;
                    item.MontoSinDescuento = saldoSinDescuento*(1+tasaInteresSaldoCredito/1200)/plazo;
                    item.Cuo.Interes_Saldo__c = capital*tasaMen;
                    capital-=item.monto- item.Cuo.Interes_Saldo__c;
                }else{
                    item.monto = saldo*(1+tasaInteresSaldoCredito/1200)/plazo;
                    item.MontoSinDescuento = saldoSinDescuento*(1+tasaInteresSaldoCredito/1200)/plazo;
                    item.Cuo.Interes_Saldo__c = capital*tasaMen;
                    capital-=item.monto- item.Cuo.Interes_Saldo__c;
                }
            }
            if(tipoFinanciamiento == 'CD'){
                item.valorPresente = item.monto*math.pow(Double.valueof(1+tasaInteresSaldoCredito/1200),Double.valueOf(-item.numeroCuota));
                item.valorPresente = item.valorPresente.setScale(2);
            }
            
            item.monto = item.Monto.setScale(2);
            item.MontoSinDescuento = item.MontoSinDescuento.setScale(2);
            item.Cuo.Fecha__c = item.fecha;
            item.Cuo.Monto_Pago__c = item.monto;
            listaCuotas.add(item);
        }
    }
    
    public decimal valorPresente {get;set;}
    public decimal montoDescuentoMaximo {get;set;}
    public boolean cambioDescuento {get;set;}
    
    public decimal getTotalMontoSaldo(){
        decimal total = 0;
        for(Cuota item :listaCuotas){
            total += item.monto;
        }
        return total;
    }
    
    public decimal getTotalMontoSaldoEntrada(){
        decimal total = 0;
        for(Cuota item :listaCuotasEntrada){
            total += item.monto;
        }
        return total;
    }
    
    public void actualizarDescuento(){
        
        if(descuento > monto){ 
            descuento = 0; 
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'No puede ingresar un descuento mayor al monto total'));
        }
        
        actualizarMonto();
        
        recalcularDescuentoPor();
        recalcularAlertaDescuento();
        //verificarRentabilidad();
    }
    
    
    public class Cuota implements Comparable{
        public decimal Monto {get;set;}
        public decimal MontoSinDescuento {get;set;}
        public date Fecha {get;set;}
        public decimal Impuesto {get;set;}
        public integer numeroCuota {get;set;}
        public boolean modificada {get;set;}
        public Cuota_Financiamiento__c Cuo {get;set;}
        public extensionCotizacion controller {get;set;}
        public boolean cuotaAgregada {get;set;}
        public decimal valorPresente {get;set;}
        public decimal diasPago {get;set;}
        public boolean seleccionar;
        
        public Cuota(extensionCotizacion controller){
            Cuo = new Cuota_Financiamiento__c();
            this.controller = controller;
            MontoSinDescuento = 0;
            seleccionar = false;
        }
        
        public Cuota(extensionCotizacion controller, Cuota_Financiamiento__c cuota){
            Cuo = cuota; 
            this.controller = controller; 
            Monto = cuota.Monto_Pago__c; 
            MontoSinDescuento = Monto; 
            valorPresente = cuota.Valor_Presente__c; 
            Fecha = cuota.Fecha__c; 
            seleccionar = cuota.Es_Personalizado__c;
        }
        
        public boolean getSeleccionar(){
            if(modificada != null && modificada){
                return true;
            }else if(cuotaAgregada != null && cuotaAgregada){
                return true;
            }else{
                return false;
            }
        }
        
        public void setSeleccionar(boolean newVal){
            modificada = newVal;
        }
        
        public void modificar(){
            if(cuotaAgregada == null || !cuotaAgregada){
                modificada = true;
                System.debug('Cuota Modificada');
            }
            MontoSinDescuento = Cuo.Monto_Pago__c;
            monto = Cuo.Monto_Pago__c;
            System.debug('Numero Cuota Modificar: '+numeroCuota+' Monto: '+monto);
            if(numeroCuota==0){
                controller.montoCuotaPrima = Cuo.Monto_Pago__c;
                controller.porcentajeCuotaPrima = Cuo.Monto_Pago__c*100/controller.monto;
                controller.porcentajeCuotaPrima = controller.porcentajeCuotaPrima.setScale(2);
                controller.recalcularMontoCuotaPrima();
            }else{
                Cuo.Es_Personalizado_Cuota_Original__c = true;
            }
            controller.calcularCoutasSaldoEntrada();
        }
        
        public void eliminar(){
            if(numeroCuota != 0){
                modificada = true;
                Cuo.Monto_Pago__c = 0;
                Monto = 0;
                MontoSinDescuento = 0;
                Cuo.Es_Personalizado_Eliminacion__c = true;
                controller.calcularCoutasSaldoEntrada(); 
            }else{ 
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'No se puede eliminar la cuota Inicial.')); 
                return;
            }
        }
        
        public Integer compareTo(Object compareTo) {
                Cuota item2 = (Cuota)compareTo;
            if(Cuo.Fecha__c>item2.Cuo.Fecha__c){
                return 1;
            }else{
                return -1;
            }
        }
    }
}