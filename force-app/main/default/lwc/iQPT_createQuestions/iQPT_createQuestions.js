import { LightningElement, track } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
export default class IQPT_createQuestions extends LightningElement {
    @track isModalShown = false;
    @track recordId;

    openModal() {
        this.isModalShown = true;
    }

    closeModal() {
        this.isModalShown = false;
    }

    /*handleSuccess(event) {
        this.recordId = event.detail.id;
        console.log('onsuccess: ', this.recordId);
        // closing modal
        this.closeModal();

        // showing success message
        this.dispatchEvent(new ShowToastEvent({
            title: 'Success!!',
            message: 'Record Created Successfully!!.',
            variant: 'success'
        }));

    }*/

    handleSubmit(event) {
        // prevending default type sumbit of record edit form
        event.preventDefault();
        console.log('handleSubmit clicked'+this.template.querySelectorAll('lightning-input-field'));
        var isVal = true;
        this.template.querySelectorAll('lightning-input-field').forEach(element => {
            isVal = isVal && element.reportValidity();
        });

        if (isVal) {
            // querying the record edit form and submiting fields to form
            this.template.querySelector('lightning-record-edit-form').submit();
            console.log('handleSubmitteddd');
            this.closeModal();

        // showing success message
        this.dispatchEvent(new ShowToastEvent({
            title: 'Success!!',
            message: 'Record Created Successfully!!.',
            variant: 'success'
        }));
       
        } else {
            // showing success message
            this.dispatchEvent(new ShowToastEvent({
                title: 'Error!!',
                message: 'Please Fill the required fields',
                variant: 'error'
            }));
        }



    }
}