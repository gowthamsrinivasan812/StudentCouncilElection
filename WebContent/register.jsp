<script>
   
    const urlParams = new URLSearchParams(window.location.search);
    if (urlParams.has('error') && urlParams.get('error') === 'email_exists') {
        if (confirm("This email is already registered. Please use another email.")) {
            window.location.href = "voterreg.jsp";
        }
    }
</script>
