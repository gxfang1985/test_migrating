import {formatMembers} from "./appointment_field";
const $ = jQuery;

/**
 * Bind event and set data for event candidate properties (attendeesCandidate, watchersCandidate)
 * @param {string} member_add_instance_name Member add instance name
 * @param {string} candidate_property_name Candidate property name in Event Object
 * @param {string} event_name Event name
 */
export const bindCandidateListChangeEventFor = (member_add_instance_name, candidate_property_name, event_name) => {
    const member_add_instance = grn.component.member_add.get_instance(member_add_instance_name);
    if (!member_add_instance) {
        return undefined;
    }
    return new garoon.Promise((resolve) => {
        member_add_instance.on("candidateListChange", (e, members) => {
            garoon.schedule.data[event_name].event[candidate_property_name] =
                formatMembers(members);
            resolve();
        });
    });
};

/**
 * Sync member candidate & Observer candidate. After sync then call trigger to JS API
 * @param {string} event_name Event name
 */
export const syncMembers = (event_name) => {
    const promises = [];
    if (grn.base.isNamespaceDefined("garoon.schedule.data")
        && garoon.schedule.data.isCustomizationAvailable
        && garoon.schedule.data[event_name]) {
        let event_data = $.extend(true, {}, garoon.schedule.data[event_name]);
        if (event_data.event.hasOwnProperty("attendeesCandidate")) {
            promises.push(bindCandidateListChangeEventFor("member_select", "attendeesCandidate", event_name));
        }
        if (event_data.event.hasOwnProperty("watchersCandidate")) {
            promises.push(bindCandidateListChangeEventFor("private_select", "watchersCandidate", event_name));
        }
        garoon.Promise.all(promises).then(() => {
            event_data = $.extend(true, {}, garoon.schedule.data[event_name]);
            event_data.type = event_name;
            if (event_data.hasOwnProperty("no_trigger")) {
                delete event_data.no_trigger;
            }
            garoon.events.trigger(event_name, event_data);
        }).catch((error) => {
            if (window.console) {
                console.error(error); // eslint-disable-line no-console
            }
        });
    }
};