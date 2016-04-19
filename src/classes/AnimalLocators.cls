public class AnimalLocators {

    public static String getAnimalNameById(Integer temp){
        Http objHttp=new Http();
        List<Object> animalList=new List<Object>();
        String resultAnimal;
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals/'+temp);
        request.setMethod('GET');
        HttpResponse response = objHttp.send(request);
        if(response.getStatusCode() == 200){
            Map<String, Object> animalResult = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            animalList = (List<Object>)animalResult.get('animals');
            system.debug(animalResult);
            for(Object objAnimal: animalList){
                resultAnimal=(String)objAnimal;
            }
            system.debug('received the response');
        }
        return resultAnimal; 
    }

}