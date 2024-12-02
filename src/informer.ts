#!/usr/bin/env node --nolazy -r ts-node/register -r tsconfig-paths/register

import Operator from './operator';
import { CustomObjectsApi, KubernetesListObject, KubernetesObject } from '@kubernetes/client-node';

export default class MyOperator extends Operator {
    protected async init() {
        const customObjectsApi = this.kubeConfig.makeApiClient(CustomObjectsApi)
        const listFnBody = async () => {
            const res = await customObjectsApi.listClusterCustomObject('lkecluster.linode.com', 'v1alpha1', 'aplinstalls');
            return {
                response: res.response,
                body: res.body as KubernetesListObject<KubernetesObject>,
            };
        };
        // Call the watchResourceWithInformer with the listFn
        await this.informResource(
            'v1alpha1',
            'aplinstalls',
            async (event) => {
                console.log('Received event:', event.type, event.meta.name);
                console.log('Object:', event.object);
                console.log(new Date().toISOString());
            },
            listFnBody,
            'lkecluster.linode.com',
        )
    }
}

const operator = new MyOperator();

async function main() {
    await operator.start()
    const exit = (reason: string) => {
        console.log(reason)
        operator.stop()
        process.exit(0)
    }
    process.on('SIGTERM', () => exit('SIGTERM')).on('SIGINT', () => exit('SIGINT'))
}

main()



