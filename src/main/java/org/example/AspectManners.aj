package org.example;

public aspect AspectManners {

    // Pointcut для методов, начинающихся на get
    pointcut getterMethods(): execution(* HelloWorld.get*(..));

    // Pointcut для методов, начинающихся на set
    pointcut setterMethods(): execution(* HelloWorld.set*(..));

    // Логгирование до выполнения метода get
    before(): getterMethods() {
        System.out.println("Something was getted. " + thisJoinPoint +
                " Timestamp: " + System.currentTimeMillis());
    }

    // Логгирование до выполнения метода set
    before(): setterMethods() {
        System.out.println("Something was setted. " + thisJoinPoint +
                " Timestamp: " + System.currentTimeMillis());
    }
    pointcut sayMethod(): execution(* HelloWorld.say*(..));
    before(): sayMethod() {
        System.out.println("Good day!");
    }



    after(): sayMethod() {
        System.out.println("Nice to meet you!");
    }
    pointcut methodsWithoutSay(): execution(* HelloWorld.*(..)) && !sayMethod();


    pointcut callSayMessageToPerson(String name, String familyName) :
            call(* HelloWorld.sayToPerson(String, String, String)) && args(*, name, familyName);

    void around(String name, String familyName): callSayMessageToPerson(name, familyName) {
        // Добавляем "-san" только к имени
        proceed(name + "-san", familyName);
    }

    before(): methodsWithoutSay() {
        System.out.println("Entering method without say: " + thisJoinPoint.getSignature() +
                " Timestamp: " + System.currentTimeMillis());
    }

    after(): methodsWithoutSay() {
        System.out.println("Leaving method without say: " + thisJoinPoint.getSignature() +
                " Timestamp: " + System.currentTimeMillis());
    }
}
