import Sortable from 'sortablejs';

const initSortable = (element) => {
  new Sortable(element, {
    animation: 300
  });
};

export { initSortable };
