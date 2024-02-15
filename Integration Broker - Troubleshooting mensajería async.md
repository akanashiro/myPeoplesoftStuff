# Integration Broker - Resolución a problemas de integración asincrónica

Guía de resolución de problemas para procesos de publicación, suscripción y otros problemas posibles.

## Problemas en el Proceso de Publicación

Los posibles problemas de publicación incluyen:

- [Publication Contract no es creado.][pub1]
- [Publication Contract está en estado NEW.][pub2]
- [Publication Contract queda en estado RETRY.][pub3]
- [Publication Contract está en estado WORKING.][pub4]
- [Publication Contract está en estado TIMEOUT.][pub5]
- [Publication Contract está en estado ERROR.][pub6]

### Publication Contract no es creado

Posibles causas:

- No existe PeopleCode de publicación.
- El PeopleCode de publicación es incorrecto.
- No existen rutas de salida para el Service Operation.

### Publication Contract está en estado NEW

Posibles causas:

- La cola de envío está pausada
- El Publication Dispatcher falló (crash) y está caído.
- El nodo de envío está pausado
- Hay Service Operation anteriores con estado Retry, Error o Timeout
- El dominio de envío está inactivo.
- Después de un ping sin éxito, una fila puede haber sido agregada a la tabla PSNODESDOWN; donde se mantiene la cola de mensaje. Hay que hacer una query a PSNODESDOWN

### Publication Contract se queda en estado RETRY

Posibles causas:

- No se recibe respuesta haciendo un ping al nodo remoto; el Publication Contract será procesado cuando el nodo remoto aparezca.
- No hay Handler de publicación disponible, tanto porque falló (crash) o se cayó.
- La URL del nodo de recepción es incorrecto en el archivo integrationGateway.properties

### Publication Contract está en estado WORKING

Posibles causas:

- El handler de publicación procesando el contrato está en otra máquina y tanto la máquina o el dominio están bajados. El procesamiento debería continúan cuando el sistema de publicación/suscripción vuelva a estar en línea.
- Un threading simple en el Application Server ralentiza el procesamiento.

### Publication Contract está en estado TIMEOUT

Posibles causas:

- Ocurrió una excepción en el Application Server de destino (fijarse en APPSRV.LOG); Verificar que:

- La respuesta está incorrectamente ruteada; chequear que el Gateway  esté la dirección correcta de las máquinas o nodo destino.
- Sintaxis de XML errónea.

### Publication Contract está en estado ERROR

Posibles causas:

- El perfil del usuario del nodo receptor no está autorizado para Service Operation.
- El ruteo de entrada no está seteado en el sistema de recepción.
- Al Service Operation no se le ha dado seguridad de acceso en el sistema de recepción.
- El PeopleCode del Handler tiene algún error.
- El Application Server remoto está bajado.
- El nodo de recepción no está definido en el archivo integrationGateway.properties.
- La versión del Service Operation en el destino no está activa.

## Problemas en el Proceso de Suscripción

Los posibles problemas de suscripción incluyen:

- [Subscription Contract no es creado.][sub1]
- [Subscription Contract está en estado NEW.][sub2]
- [Subscription Contract está en estado STARTED.][sub3]
- [Subscription Contract está en estado WORKING.][sub4]
- [Subscription Contract está en estado ERROR.][sub5]
- [Subscription Contract está en estado EDIT.][sub6]

### Subscription Contract no es creado

Posibles causas:

- El handler no existe para ese Service Operation.
- Al handler del Service Operation le falta un método.
- Las reglas de ruteo de la cola no están seteadas apropiadamente.

### Subscription Contract está en estado NEW

Posibles causas:

- El Application Server está bajado.
- Los procesos de publicación/suscripción no están configurados en el dominio del Application Server.
- El Subscription Dispatcher falló (crash) o ha sido bajado.
- La cola de recepción está pausada.
- El nodo de recepción está pausado.
- Hay Service Operations anteriores con errores o con time out.
- Ninguna fila fue insertada en PSAPMSGSUBPRCID. Para insertar una fila ejecutar la siguiente consulta: insert into PSAPMSGSUBPRCID values(0)

### Subscription Contract está en estado STARTED

Posibles causas:

- El Handler de suscripción está inactivo.
- El componente de destino no es válido.

### Subscription Contract está en estado WORKING

Posibles causas:

- El Handler de suscripción colgado mientras se procesa el mensaje.

### Subscription Contract está en estado ERROR

Posibles causas:

- La propiedad de la cola si está ordenada permite a los Subscription Contracts ir en orden aleatorio, lo cual causa que los Service Operations FULLSYNC que den error cuando la transacción está suscripta antes que el primero.
- Existen errores de PeopleCode en el Handler del Service Operation.
- Existen errores de datos de  Aplicación.

### Subscription Contract está en estado EDIT

- La causa posible es que el XML fue editado y no fue reenviado para procesarlo

## Otros posibles problemas:

- [No puede encontrarse un Service Operation en el Monitor.][other1]
- [Los Service Operation son procesados en en el orden incorrecto.][other2]
- [No se crea instancia de Service Operation.][other3]
- [La instancia del Service Operation se mantiene en estado NEW.][other4]
- [La instancia del Service Operation se mantiene en estado STARTED.][other5]
- [La instancia del Service Operation se mantiene en estado WORKING.][other6]
- [No se puede hacer ping al nodo.][other7]
- [La cola está PAUSED.][other8]

### No puede encontrarse un Service Operation en el Monitor

- La posible causa es que se esté usando mal el filtrado en el Monitor.

### Los Service Operation son procesados en en el orden incorrecto

- La causa posible es que la cola fue particionada y el resultado de las subcolas no coincide con la que fue asumida para el ordenamiento de service operations.

### No se crea instancia de Service Operation

- La posible causa es que el Service Operation esté inactivo

### La instancia del Service Operation se mantiene en estado NEW

Posibles causas:

- El Application Server está bajado.
- Los servicios de publicación/suscripción no están configurados en el dominio del Application Server.
- El Message Dispatcher falló (crash) o está bajado.
- El ítem no está en el tope de la cola; todos los Service Operation con la misma cola o subcola están en la misma cola.

### La instancia del Service Operation se mantiene en estado STARTED

Posibles causas:

- Todos los Handlers del mensaje fallaron (crash) o están abajo; el procesamiento se retomará cuando los Handlers del mensaje vuelvan a funcionar.
- El Message Dispatcher que procesa el mensaje está en otra máquina, la máquina o el dominio del Application Server están bajados.

### La instancia del Service Operation se mantiene en estado WORKING

Posibles causas:

- El Handler del Message Broker falló (crash).
- El Message Handler que procesa el mensaje está en otra máquina, la máquina o el dominio del Application Server está bajado.
- El Message Handler que está trabajando en el mensaje está bloqueado. El servicio va a llegar a un time, out y el Message Dispatcher va a reintentar de procesar el mensaje.

### No se puede hacer ping al nodo

Posibles causas:

- El servidor web del Gateway está bajado.
- El Gateway no está configurado apropiadamente.
- El Application Server para el nodo está bajado.
- La URL del Gateway es incorrecta; verificar que la URL se la correcta. Copiar la URL en el navegador y tendría que verse.

```
PeopleSoft Integration Gateway
PeopleSoft Listening Connector
Status: ACTIVE
```


### La cola está PAUSED

- La causa posible es que algunas de las colas son enviadas como pausadas. Cambie el estado a RUN para que el process de Service Operation pase de NEW a WORKING.


[pub1]: #publication-contract-no-es-creado
[pub2]: #publication-contract-está-en-estado-new
[pub3]: #publication-contract-se-queda-en-estado-retry
[pub4]: #publication-contract-está-en-estado-working
[pub5]: #publication-contract-está-en-estado-timeout
[pub6]: #publication-contract-está-en-estado-error
[sub1]: #subscription-contract-no-es-creado
[sub2]: #subscription-contract-está-en-estado-new
[sub3]: #subscription-contract-está-en-estado-started
[sub4]: #subscription-contract-está-en-estado-working
[sub5]: #subscription-contract-está-en-estado-error
[sub6]: #subscription-contract-está-en-estado-edit
[other1]: #no-puede-encontrarse-un-service-operation-en-el-monitor
[other2]: #los-service-operation-son-procesados-en-en-el-orden-incorrecto
[other3]: #no-se-crea-instancia-de-service-operation
[other4]: #la-instancia-del-service-operation-se-mantiene-en-estado-new
[other5]: #la-instancia-del-service-operation-se-mantiene-en-estado-started
[other6]: #la-instancia-del-service-operation-se-mantiene-en-estado-working
[other7]: #no-se-puede-hacer-ping-al-nodo
[other8]: #la-cola-está-paused