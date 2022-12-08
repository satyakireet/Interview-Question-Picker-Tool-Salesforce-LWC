import { LightningElement, track, wire } from 'lwc';
import getQuestionEvaluationCriteria from '@salesforce/apex/IQ_EvaluationCriteriaController.getQuestionEvaluationCriteria';
import { refreshApex } from '@salesforce/apex';
const actions = [
    { label: 'View Details', name: 'View' },
    { label: 'Edit Details', name: 'Edit' },
];
const Allcolumns = [
    { label: 'Competency', fieldName: 'Competency__c', sortable: true },
    { label: 'Topic', fieldName: 'Topics__c', sortable: true },
    { label: 'No of Easy Q', fieldName: 'No_of_Easy_Q__c', sortable: true },
    { label: 'No of Medium Q', fieldName: 'No_of_Medium_Q__c', sortable: true },
    { label: 'No of Hard Q', fieldName: 'No_of_Hard_Q__c', sortable: true },
    { label: 'Date', fieldName: 'Date__c', sortable: true },
    { label: 'Email', fieldName: 'Email__c', sortable: true },
    {
        type: 'action',
        typeAttributes: { rowActions: actions },
    },
];

export default class IQPT_EvaluationCriteriaListView extends LightningElement {
    @track currentRecordId;
    @track sortBy;
    @track sortDirection;
    @track AlltableColumns = Allcolumns;
    @wire(getQuestionEvaluationCriteria) qecDetails;

    handlesuccess(event) {
        refreshApex(this.qecDetails);
    }

    handleRowAction(event) {
        let actionName = event.detail.action.name;
        const row = event.detail.row;
        this.currentRecordId = row.Id;
        console.log("Row Data >>" + JSON.stringify(row));
        switch (actionName) {
            case 'View':
                alert("View Action");
                break;
            case 'Edit':
                alert("Edit Action");
                break;
            default:
        }
    }

    handleSortData(event) {
        let fieldName = event.detail.fieldName;
        let sortDirection = event.detail.sortDirection;
        //assign the values
        this.sortBy = fieldName;
        this.sortDirection = sortDirection;
        //call the custom sort method.
        this.sortData(fieldName, sortDirection);
    }
    sortData(fieldname, direction) {
        // serialize the data before calling sort function
        //console.log('DAtA RAVISH DATA DATA =========' + JSON.parse(JSON.stringify(this.taskList)));
        let parseData = JSON.parse(JSON.stringify(this.qecDetails.data));

        // Return the value stored in the field
        let keyValue = (a) => {
            return a[fieldname];
        };
        // cheking reverse direction 
        let isReverse = direction === 'asc' ? 1 : -1;
        // sorting data 
        parseData.sort((x, y) => {
            x = keyValue(x) ? keyValue(x) : ''; // handling null values
            y = keyValue(y) ? keyValue(y) : '';

            // sorting values based on direction
            return isReverse * ((x > y) - (y > x));
        });
        // set the sorted data to data table data
        this.qecDetails.data = parseData;
    }

}