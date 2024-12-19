import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    const isClosed = sessionStorage.getItem('sidebarClosed') === 'true';
    const isExpanded = sessionStorage.getItem('sidebarExpanded') === 'true';
    
    if (isClosed) {
      this.element.classList.add('closed');
    }
    if (isExpanded) {
      this.element.classList.add('expanded');
    }

    // Xử lý khi chuyển trang
    document.addEventListener('turbo:visit', () => {
      this.element.classList.add('transitioning');
    });

    document.addEventListener('turbo:load', () => {
      setTimeout(() => {
        this.element.classList.remove('transitioning');
      }, 300); // Đợi transition hoàn thành
    });
  }

  toggle(event) {
    event.preventDefault();
    event.stopPropagation();
    
    if (this.element.classList.contains('closed')) {
      this.element.classList.remove('closed');
      setTimeout(() => {
        this.element.classList.add('expanded');
      }, 50);
    } else {
      this.element.classList.add('expanded');
    }
    sessionStorage.setItem('sidebarClosed', 'false');
    sessionStorage.setItem('sidebarExpanded', 'true');
  }

  close(event) {
    event.preventDefault();
    event.stopPropagation();
    
    this.element.classList.remove('expanded');
    setTimeout(() => {
      this.element.classList.add('closed');
    }, 50);
    
    sessionStorage.setItem('sidebarExpanded', 'false');
    sessionStorage.setItem('sidebarClosed', 'true');
  }
} 