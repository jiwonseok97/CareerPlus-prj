package com.wa.erp.config.datasource;

import org.springframework.jdbc.datasource.lookup.AbstractRoutingDataSource;
import org.springframework.transaction.support.TransactionSynchronizationManager;

public class ReplicationRoutingDataSource extends AbstractRoutingDataSource {

    private boolean routeNonTransactionalToSlave = true;

    public void setRouteNonTransactionalToSlave(boolean routeNonTransactionalToSlave) {
        this.routeNonTransactionalToSlave = routeNonTransactionalToSlave;
    }

    @Override
    protected Object determineCurrentLookupKey() {
        if (TransactionSynchronizationManager.isCurrentTransactionReadOnly()) {
            return DatabaseType.SLAVE;
        }

        if (!TransactionSynchronizationManager.isActualTransactionActive() && routeNonTransactionalToSlave) {
            return DatabaseType.SLAVE;
        }

        return DatabaseType.MASTER;
    }
}
