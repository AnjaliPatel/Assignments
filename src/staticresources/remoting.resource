<script>
        function deleteSingleContact(deleteContactId){
            Visualforce.remoting.Manager.invokeAction(
                '{!$RemoteAction.ManipulateContactExtension.deleteSingle}',
                deleteContactId,
                function(result,event){
                    if(event.status){
                        alert(result);
                    }
                    else{
                        document.getElementById(exceptionMessage).innerHTML=event.message;
                    }
                },
                {escape:true}
            );
        }
</script>  