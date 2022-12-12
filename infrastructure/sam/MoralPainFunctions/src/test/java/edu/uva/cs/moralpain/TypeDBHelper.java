package edu.uva.cs.moralpain;

import com.vaticle.typedb.client.api.TypeDBClient;
import com.vaticle.typedb.client.api.TypeDBOptions;
import com.vaticle.typedb.client.api.TypeDBSession;
import com.vaticle.typedb.client.api.TypeDBTransaction;

import java.util.function.Consumer;

import static com.vaticle.typedb.client.api.TypeDBSession.Type.DATA;
import static com.vaticle.typedb.client.api.TypeDBTransaction.Type.WRITE;

public class TypeDBHelper {
    TypeDBClient typedbClient;
    String dbName;

    public TypeDBHelper(TypeDBClient client, String dbName) {
        typedbClient = client;
        this.dbName = dbName;

    }

    public void localhostTypeDBTX(Consumer<TypeDBTransaction> fn, TypeDBTransaction.Type type) {
        localhostTypeDBTX(fn, type, TypeDBOptions.core());
    }

    public void localhostTypeDBTX(Consumer<TypeDBTransaction> fn, TypeDBTransaction.Type type, TypeDBOptions options) {
        try (TypeDBSession session = typedbClient.session(dbName, DATA)) {
            try (TypeDBTransaction transaction = session.transaction(type, options)) {
                fn.accept(transaction);
            }
        }
    }

    public void localhostTypeDBTX(Consumer<TypeDBTransaction> fn, TypeDBSession.Type sessionType) {
        try (TypeDBSession session = typedbClient.session(dbName, sessionType)) {
            try (TypeDBTransaction transaction = session.transaction(WRITE)) {
                fn.accept(transaction);
            }
        }
    }
}
