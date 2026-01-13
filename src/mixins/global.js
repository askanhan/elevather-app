import { reactive, toRefs } from 'vue'

export default {
  methods: {
    _findJaarvorderingsplannenActivityRecord(key) {
      if (key && key.length > 0) {
        const sessionData = sessionStorage.getItem('VUE_CUSTOM_CURRICULA');
        if (sessionData !== null) {
          const sessionConfigCustomCurricula = JSON.parse(sessionData);
          for (const customCurricula of sessionConfigCustomCurricula) {
            for (const llinkidFlattedActivity of customCurricula.Activiteiten) {
              if (llinkidFlattedActivity.ID === key) {
                return llinkidFlattedActivity;
              }
            }
          }
        }
      }
    },

    _recHasChanged(origRec, rec, ignoreItems) {
      if (ignoreItems && ignoreItems.length > 0) {
        for (const ignoreItem of ignoreItems) {
          delete origRec[ignoreItem];
          if (!this._isEmpty(rec) && !this._isEmpty(ignoreItem)) {
            delete rec[ignoreItem];
          }
        }
      }
      return !_.isEqual(origRec, rec);
    },

    _selectieAllesNiets(list, trueFalse, childrenField, enableEvenIfDisabled) {
      for (let y1 = 0; y1 < list.length; y1++) {
        const rec = list[y1];
        if (enableEvenIfDisabled) {
          rec.Disabled = false;
        }
        if (!rec.Disabled) {
          rec.Actief = trueFalse;
          if (childrenField) {
            const childArray = rec[childrenField];
            for (const childRec of childArray) {
              if (!childRec.Disabled) {
                childRec.Actief = rec.Actief;
              }
            }
          }
        }
      }
    },

    _selectEnigeRecord(list, actiefRec, primaryKeyNotID) {
      for (const rec of list) {
        if (primaryKeyNotID) {
          rec.Actief = rec[primaryKeyNotID] === actiefRec[primaryKeyNotID];
        } else {
          rec.Actief = rec.ID === actiefRec.ID;
        }
      }
    },

    _getEnigeActieveRecord(list) {
      return list.find(rec => rec.Actief);
    },

    _getAlleActieveRecord(list) {
      return list.filter(rec => rec.Actief);
    },

    _selectieRecord(list, index, rec, childrenField, parentOfChild, oneChildActiveIsParentActive, specialDisableField) {
      if (rec.Disabled || specialDisableField) {
        console.log('niets doen');
      } else {
        rec.Actief = rec.Actief === undefined ? true : !rec.Actief;
        if (childrenField) {
          const childArray = rec[childrenField];
          for (const childRec of childArray) {
            if (!childRec.Disabled) {
              childRec.Actief = rec.Actief;
            }
          }
        }
        if (parentOfChild) {
          const noActiveChild = !list.some(listItem => listItem.Actief);
          const allChildsActive = list.every(listItem => listItem.Actief);
          parentOfChild.Actief = allChildsActive || (oneChildActiveIsParentActive && !noActiveChild);
        }
      }
    },

    _selectieSiblingChildsRecordThroughParentRec(list, indexInList, parent, indexParent, selectedChildecord, selectedChildecordIndex, childField, checkField) {
      if (selectedChildecord.Disabled) {
        console.log('niets doen');
      } else {
        const inverseValue = !selectedChildecord.Actief;
        const parentItem = list[indexInList];
        for (const childRec of parentItem.Records) {
          const array = childRec[childField];
          for (const arrayRec of array) {
            if (arrayRec[checkField] === selectedChildecord[checkField] && !arrayRec.AlreadyExists) {
              arrayRec.Actief = inverseValue;
            }
          }
        }
      }
    },

    _checkSelectieGemaakt(list, childrenField) {
      for (const rec of list) {
        if (rec.Actief) {
          return true;
        }
        if (childrenField) {
          const childArray = rec[childrenField];
          if (childArray.some(childRec => childRec.Actief)) {
            return true;
          }
        }
      }
      return false;
    },

    _arrayVanVeld(list, field, filterBoolean) {
      return list
        .filter(rec => filterBoolean === undefined || rec[filterBoolean])
        .map(rec => rec[field]);
    },

    _stringVanVeld(list, field, seperator, filterBoolean) {
      const fieldArray = this._arrayVanVeld(list, field, filterBoolean);
      return fieldArray.join(seperator || ',');
    },

    _console() {
      console.log(...arguments);
    }
  }
}
