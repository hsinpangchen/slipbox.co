// Smooth scroll with offset for fixed navigation
document.addEventListener('DOMContentLoaded', function() {
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
        const originalText = button.textContent;

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

            button.textContent = '已複製';
            button.classList.add('is-copied');

            window.setTimeout(() => {
                button.textContent = originalText;
                button.classList.remove('is-copied');
            }, 1800);
        });
    });
});
