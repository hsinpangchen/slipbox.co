// Smooth scroll with offset for fixed navigation
document.addEventListener('DOMContentLoaded', function() {
    const localeLinks = document.querySelectorAll('[data-set-locale]');

    localeLinks.forEach(link => {
        link.addEventListener('click', function() {
            const targetLocale = link.getAttribute('data-set-locale');

            if (!targetLocale) {
                return;
            }

            try {
                window.localStorage.setItem('slip_locale', targetLocale);
            } catch (error) {
                return;
            }
        });
    });

    // Get all anchor links that point to sections on the same page
    const anchorLinks = document.querySelectorAll('a[href^="#"]');
    
    anchorLinks.forEach(link => {
        link.addEventListener('click', function(e) {
            const targetId = this.getAttribute('href');
            
            // Skip if it's just '#' or empty
            if (targetId === '#' || targetId.length <= 1) {
                return;
            }
            
            const targetElement = document.querySelector(targetId);
            
            if (targetElement) {
                e.preventDefault();
                
                // Calculate offset for fixed navigation (if present)
                const nav = document.querySelector('.nav');
                const navHeight = nav ? nav.offsetHeight : 0;
                const targetPosition = targetElement.offsetTop - navHeight - 20; // 20px extra padding
                
                window.scrollTo({
                    top: targetPosition,
                    behavior: 'smooth'
                });
            }
        });
    });

    const copyButtons = document.querySelectorAll('[data-copy-target]');

    copyButtons.forEach(button => {
        const originalText = button.getAttribute('data-copy-label') || button.textContent;
        const copiedText = button.getAttribute('data-copied-label')
            || (document.documentElement.lang && document.documentElement.lang.toLowerCase().startsWith('zh') ? '已複製' : 'Copied');

        button.addEventListener('click', async function() {
            const targetSelector = button.getAttribute('data-copy-target');
            const targetElement = targetSelector ? document.querySelector(targetSelector) : null;

            if (!targetElement) {
                return;
            }

            const textToCopy = targetElement.textContent;

            try {
                if (navigator.clipboard && navigator.clipboard.writeText) {
                    await navigator.clipboard.writeText(textToCopy);
                } else {
                    const textarea = document.createElement('textarea');
                    textarea.value = textToCopy;
                    textarea.setAttribute('readonly', '');
                    textarea.style.position = 'absolute';
                    textarea.style.left = '-9999px';
                    document.body.appendChild(textarea);
                    textarea.select();
                    document.execCommand('copy');
                    document.body.removeChild(textarea);
                }
            } catch (error) {
                return;
            }

            button.textContent = copiedText;
            button.classList.add('is-copied');

            window.setTimeout(() => {
                button.textContent = originalText;
                button.classList.remove('is-copied');
            }, 1800);
        });
    });

    const appStoreLinks = document.querySelectorAll('a[href*="apps.apple.com/"]');

    appStoreLinks.forEach(link => {
        link.addEventListener('click', function() {
            if (typeof gtag !== 'function') {
                return;
            }

            const linkText = link.textContent.trim();
            const linkLabel = link.getAttribute('data-analytics-label') || linkText;

            gtag('event', 'app_store_click', {
                link_url: link.href,
                link_text: linkText,
                link_label: linkLabel,
                page_path: window.location.pathname
            });
        });
    });
});
